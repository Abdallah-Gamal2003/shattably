# Screenshot checklist

No Shattably screenshots were found in the project or preserved local copy; the
available images are illustrations, icons and vendor examples. No Android device
was connected during the presentation review, so automatic app capture was unavailable.

Capture these from the actual application on a configured Android device/emulator
using synthetic customer and worker profiles. Save them under `docs/screenshots/`:

| Suggested file | Screen |
|---|---|
| `auth-login.png` | Login with empty fields; no real account details |
| `registration-role.png` | Registration with the customer/worker trade selection visible |
| `service-catalog.png` | Customer service catalog |
| `create-request.png` | Request description, city and date range using a synthetic job |
| `worker-orders.png` | Matching requests for the synthetic worker's city and trade |
| `order-offers.png` | Offers and the acceptance action for the synthetic request |
| `accepted-offer.png` | Accepted worker and price after accepting that offer |
| `profile.png` | Synthetic profile details |

Hide real emails, phone numbers, tokens and private job descriptions. Add the images
to the README only after visually reviewing them. Do not use production user data
to demonstrate the app.

Use portrait PNG captures at a consistent device resolution and language. Dismiss
the keyboard and system notifications unless needed to explain the screen. Do not
use stock illustrations, vendor screenshots or recreated UI as application proof.

Once reviewed, select six representative captures for a compact three-column,
two-row README table, with short captions and image widths around 220 pixels.
Until actual files are supplied, the README links only to this checklist; there
are no empty directories, placeholder images or broken image links to commit.
