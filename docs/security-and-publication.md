# Security and publication boundary

Outbound application-generated push notifications are temporarily disabled. Orders,
offers and acceptance still write to Firestore. Incoming notification support remains.
A future trusted backend must authorize actions and send messages with the Firebase
Admin SDK. No fake endpoint or replacement server credential is configured.

The project owner must revoke the exposed legacy server credential in Firebase/Google
Cloud. Local removal does not revoke it or remove previous copies from GitHub. Review
deployed Firestore/Storage rules and API-key restrictions before sharing a live demo.
Firebase client configuration is retained locally and excluded from Git; it is
not an Admin SDK credential. Never add service-account credentials to this client.

The publication branch is parentless. Only this sanitized branch is intended for
publication after review. Never push --all, --mirror, recovery branches or old tags.
Old history, the ignored nested project and ignored recovery archive remain local
and contain exposed material. They are not part of the publication tree. Replacing
existing remote history requires a separate approved plan. No pushes were made.

Personal payment/rating contact values were removed. These disconnected prototypes
are not working payment/rating integrations. No payment recipient is configured.

