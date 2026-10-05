"""Create NONFUNCTIONAL Android configuration for compilation in a clean CI checkout.

Never replaces a developer's real local Firebase configuration. This does not
create or connect to a Firebase project and is not a runnable demo backend.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
android = ROOT / "android/app/google-services.json"
dart = ROOT / "lib/firebase_options.dart"
if android.exists() or dart.exists():
    raise SystemExit("Refusing to replace existing local Firebase configuration.")

project = "portfolio-ci-placeholder"
sender = "123456789012"
app = f"1:{sender}:android:0123456789abcdef"
android.parent.mkdir(parents=True, exist_ok=True)
dart.parent.mkdir(parents=True, exist_ok=True)
android.write_text(json.dumps({
    "project_info": {"project_number": sender, "project_id": project, "storage_bucket": f"{project}.appspot.com"},
    "client": [{"client_info": {"mobilesdk_app_id": app, "android_client_info": {"package_name": "com.example.shattably"}},
                "oauth_client": [], "api_key": [{"current_key": "nonfunctional-ci-placeholder"}],
                "services": {"appinvite_service": {"other_platform_oauth_client": []}}}],
    "configuration_version": "1"
}, indent=2) + "\n", encoding="utf-8")
dart.write_text(f"""// Nonfunctional CI-only placeholders; generated, never publish as live config.
import 'package:firebase_core/firebase_core.dart';
class DefaultFirebaseOptions {{
  static const currentPlatform = FirebaseOptions(
    apiKey: 'nonfunctional-ci-placeholder', appId: '{app}',
    messagingSenderId: '{sender}', projectId: '{project}',
    storageBucket: '{project}.appspot.com',
  );
}}
""", encoding="utf-8")
print("Generated nonfunctional CI configuration. No Firebase project was contacted.")
