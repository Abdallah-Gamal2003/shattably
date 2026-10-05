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

The publication history begins at a sanitized root commit. Only this history is intended for
publication after review. Never push --all, --mirror, recovery branches or old tags.
Old history, the ignored nested project and ignored recovery archive remain local
and contain exposed material. They are not part of the publication tree. Replacing
existing remote history requires a separate approved plan. No pushes were made.

Personal payment/rating contact values were removed. These disconnected prototypes
are not working payment/rating integrations. No payment recipient is configured.


The local branch is now main. The configured origin fetch URL belongs to the selected
portfolio repository; its push URL is deliberately DISABLED. Keep it disabled until
the owner explicitly authorizes publication. No push is part of this roadmap.

The disconnected payment/rating prototypes were removed during cleanup. The core
application does not process payments or persist ratings.

After staging, scan both the index and the current publication history:

    python scripts/verify_publication.py
    python scripts/verify_publication.py --history

The history scan follows HEAD only, never recovery branches. Both scans report
paths/categories without printing credential values. Pattern scanning is a check,
not proof that external credentials have been revoked or deployed rules are secure.
