"""Scan staged blobs without printing credential values. Uses only Python stdlib."""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def git(*args):
    return subprocess.check_output(["git", *args], cwd=ROOT)


forbidden = {
    "android/app/google-services.json",
    "ios/Runner/GoogleService-Info.plist",
    "ios/firebase_app_id_file.json",
    "lib/firebase_options.dart",
    ".firebaserc",
    "firebase.json",
}
patterns = {
    "legacy FCM server credential": rb"AAAA[A-Za-z0-9_-]{4,}:APA91[A-Za-z0-9_-]+",
    "Google client API key": rb"AIza[A-Za-z0-9_-]{30,}",
    "private key": rb"-----BEGIN (?:RSA |EC |OPENSSH |ENCRYPTED )?PRIVATE KEY-----",
    "service account": rb'"type"\s*:\s*"service_account"',
    "private key JSON": rb'"private_key"\s*:\s*"[^"\r\n]{10,}',
    "GitHub token": rb"\b(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})",
    "AWS access key": rb"\b(?:AKIA|ASIA)[A-Z0-9]{16}\b",
    "Google OAuth secret": rb"GOCSPX-[A-Za-z0-9_-]+",
    "Slack token": rb"xox[baprs]-[A-Za-z0-9-]{15,}",
    "Stripe secret": rb"\bsk_(?:live|test)_[A-Za-z0-9]{16,}",
    "literal bearer token": rb"Bearer\s+[A-Za-z0-9._-]{24,}",
    "JWT-shaped token": rb"\beyJ[A-Za-z0-9_-]+\.eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+",
    "literal password/secret": rb'''(?i)(?:password|client_secret|clientSecret)\s*[:=]\s*['"][^'"\r\n]{4,}['"]''',
}
# Compare the retained local project's identifiers without exposing their values.
live_values = []
local_config = ROOT / "ios/firebase_app_id_file.json"
if local_config.exists():
    config = json.loads(local_config.read_text(encoding="utf-8"))
    live_values = [str(config[key]).encode() for key in
                   ("FIREBASE_PROJECT_ID", "GOOGLE_APP_ID", "GCM_SENDER_ID")
                   if config.get(key)]

paths = [p.decode() for p in git("ls-files", "-z").split(b"\0") if p]
findings = []
for path in paths:
    if path in forbidden or path.startswith(("shattably/", ".local-recovery/")):
        findings.append((path, "excluded publication path"))
    content = git("show", ":" + path)
    for label, pattern in patterns.items():
        if re.search(pattern, content):
            findings.append((path, label))
    if any(value in content for value in live_values):
        findings.append((path, "retained live Firebase project identifier"))

for path, label in findings:
    print(f"FAIL: {path}: {label} (value redacted)")
print(f"Scanned {len(paths)} staged files; {len(findings)} findings.")
print("Pattern scanning does not replace credential revocation or manual review.")
sys.exit(1 if findings else 0)
