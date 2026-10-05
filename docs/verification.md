# Local verification record

Verified on 2026-10-06 against source commit `ece8d9e`.

| Check | Result |
|---|---|
| Dependency resolution | `flutter pub get` succeeded |
| Analysis | 0 errors, 0 warnings, 29 style infos |
| Unit/widget/boundary tests | 16 passed |
| Android release APK | Built successfully, 67.3 MB reported by Flutter |
| CI configuration generator | Isolated smoke check passed; refuses overwrites |

The standard analyzer command reports a nonzero exit when infos are present.
These remaining diagnostics concern braces in flow-control statements; CI uses
`flutter analyze --no-fatal-infos` and still fails errors and warnings.

APK: `build/app/outputs/flutter-apk/app-release.apk` (70,608,529 bytes).
SHA-256: `29a3dba0ca8fa04fef0ee04e6f4c7e605fc765342427e07c7a279e7eb94d65fe`.
The artifact is ignored by Git and uses local Firebase configuration and debug
signing. It is for local testing, not public distribution or store submission.

Toolchain: Flutter 3.24.4, Dart 3.5.4, JDK 17, Gradle 8.9, AGP 8.7.3,
Kotlin 2.1.10, compile/target SDK 35, min SDK 23, NDK 25.1.8937393.
The build still recommends NDK 27.0.12077973 for plugins; it completed with 25.1.

The local SDK launcher workaround described in `android-baseline.md` invoked
the installed Flutter tool snapshot for these commands. Logs remain in ignored
local recovery storage. No hosted CI run or Firebase/device end-to-end verification
is claimed. Server rules, emulator contention tests, release signing, backend push
delivery and asset-license review remain follow-up work.

Publication checks scan the index and reachable HEAD history. Recovery refs and
the preserved legacy project are deliberately outside the publication history.
The original exposed credential still requires owner-side revocation; a clean
source scan cannot establish revocation.
