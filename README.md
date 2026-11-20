# ZeroWasteKit

An open-source dashboard to track food, inventory, and eliminate household waste.

ZeroWasteKit is a single-page, dependency-free web app for managing a household inventory and turning what you already own into sensible meals. It runs entirely in the browser and stores data through WorkBuddy's built-in database, with a `localStorage` fallback so the page never goes blank.

## Features

- **Inventory dashboard** — total items in stock, expiring soon (within 7 days), earliest expiry, and a top-3 alert list.
- **Meal draw ("翻牌子")** — generates breakfast, lunch, and dinner from a hard-coded recipe dictionary. Combinations are curated for real cooking sense, so you never get odd pairings.
- **Expiry-first consumption plan** — suggests a capped daily amount per category so you use up short-dated food without being told to finish everything in one day.
- **Weekly menu** — a 7-day foldable menu that hides any dish whose ingredients are out of stock.
- **Inline editing** — edit quantity, category, and expiry date directly in the inventory table; changes sync instantly.
- **Self-grown produce ledger** — track herbs and vegetables you grow at home; harvestable items feed into meal planning at zero cost.
- **Weekly fund ledger** — log small weekly spend on fresh produce, eggs/dairy, and supplements, with weekly and monthly caps.

## Design principles

- Single HTML file, vanilla JavaScript only — no frameworks, no build step, no third-party cloud.
- Quantity is a **text** field, so values like `750g`, `4个`, or `1瓶` work naturally.
- Fresh mint-green theme, white rounded cards, responsive on phone and desktop.
- All data stays in your own account and browser.

## Getting started

Open `index.html` in a browser. When hosted inside WorkBuddy, the page binds to the built-in database automatically; when opened locally, it falls back to browser storage.

## License

Released under the MIT License. See [LICENSE](LICENSE).
