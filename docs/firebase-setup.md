# Configure your own Firebase project

Android is the primary target. Live Firebase client configuration is deliberately
excluded from this repository. The original developer's local files are retained
on disk, but they are not included in the publication history.

## Prerequisites

Install Flutter 3.24.4, the Android SDK/JDK in `android-baseline.md`, Firebase CLI
and FlutterFire CLI. Authenticate
the Firebase CLI with your own account. Do not copy another developer's credentials.

```sh
firebase login
dart pub global activate flutterfire_cli
flutterfire configure --project=YOUR_PROJECT_ID --platforms=android --android-package-name=com.example.shattably
```

The package name must match `android/app/build.gradle`. If you change it, update
the Android namespace/activity package and register that exact ID in Firebase.
The checked-in application ID is retained for compatibility during modernization.

Verify that configuration created `lib/firebase_options.dart`. Download your
Android app's `google-services.json` from Firebase project settings and place it
at `android/app/google-services.json` if the CLI did not generate it. Both files
are ignored by Git. There is no shared demo account or public database configured.

## Firebase services

1. Enable Authentication's Email/Password provider. Configure verification and
   password-reset email templates. The app requires a verified email to proceed.
2. Create Cloud Firestore and Cloud Storage in suitable regions. Supply billing
   if required by the services. Start with denied access and deploy reviewed rules;
   do not enable unrestricted read/write access to make the demo work.
3. Configure ownership rules for `profiles/{uid}`, `orders`, and `offers`.
   Customers may change only their own orders; workers may submit only their own
   offers. Enforce the relationship between an offer, its order and its owner.
   Protect private contact fields and device tokens. Client checks are not security.
4. Scope profile-image Storage access to the authenticated owner. Registration
   creates the Auth account before uploading a selected photo. Permit owners to
   write only their own `profiles/{uid}/...` path; do not loosen rules globally.
5. Exercise customer and worker queries against your development project and
   create any composite indexes requested by Firestore. Export reviewed rules
   and indexes before relying on the project for a public live demo.

The active collections are `profiles`, `orders`, and `offers`.
This repository does not yet provide production-ready
security rules or reproducible seed data. Create only synthetic test profiles.

## Notifications

The app can register for and receive Firebase messages. Use an Android emulator
with Google Play services or a physical device and grant notification permission.
Application-generated outbound notifications are intentionally disabled until a
trusted backend is implemented. Saving an order/offer does not currently notify
the other party. Never embed a server key, service-account JSON, or Admin SDK
credential in Flutter code, assets, environment files or build arguments.

## Other platforms

iOS is not part of the verified Android baseline. If enabling it later, register
your own iOS app and run FlutterFire configuration for that platform. Keep
`ios/Runner/GoogleService-Info.plist` and `ios/firebase_app_id_file.json` local.
Configure Apple signing, permissions and APNs separately. Do not assume the
existing web/desktop scaffolding is supported.

## Publication check

Run `python scripts/verify_publication.py` after staging changes. It checks the
Git index, not just working files. Do not force-add the ignored Firebase files.
See `security-and-publication.md` for exposed-credential revocation and the
restriction on publishing recovery branches or old history.
