# Android modernization baseline

Target Flutter **3.24.4**, Dart **3.5.4**, JDK **17**, Gradle **8.9**, Android
Gradle Plugin **8.7.3**, Kotlin **2.1.10**, compile/target SDK **35**, minimum SDK
**23**. This deliberately bounded compatibility baseline is not a claim of using
the latest SDK or meeting current Google Play submission requirements.

Install that Flutter release and Android SDK platform 35 and build-tools 34/35 plus NDK
25.1.8937393. Select a JDK 17 installation for Flutter (`flutter config --jdk-dir`
on your own machine). No machine paths
belong in tracked files. Configure Firebase using [firebase-setup.md](firebase-setup.md).

Run from the root project:

```sh
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk
```

Dependencies are deliberately pinned, with the application lockfile committed.
Firebase remains on the compatible core 2.x/auth 4.x generation to limit migration
scope. Syncfusion uses one hosted date-picker package; the old source copy is
preserved only in ignored recovery storage. Its license still applies to use of
the hosted package. `IconBroken` font registration fixes missing existing icons.

Android uses the Gradle plugins DSL, Google Services plugin and Java desugaring
for local notifications. The application ID remains unchanged to keep local
Firebase configuration working. Release APKs currently use the existing debug
signing configuration for local testing; they are not store-ready releases.

Outbound app-triggered push messages remain disabled. No Clean Architecture/MVVM
migration or UI redesign is included in this phase. iOS/web/desktop are unverified.

The call-worker action uses `url_launcher` to open a `tel:` URI in the phone app.
The user confirms the call there. This replaces the incompatible direct-calling
plugin without modifying the global Pub cache.
