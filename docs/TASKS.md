## Project Task Log

- 2025-09-23: Created/updated `.gitignore` for Node/Next.js + Hardhat. Removed `docs/` from ignore, deduped entries, added `.eslintcache` and `.supabase/`.
- 2025-09-23: Added `contracts/CreditNameService.sol` with 1000 tCTC fixed-price and 1-year terms.
- 2025-09-23: Switched Hardhat to `creditTestnet` via env; added `scripts/deploy-credit.js`; updated `package.json` script/name.
- 2025-09-23: Updated frontend to use Credit contract (`getCreditContract`), changed UI to `.ctc` and 1000 tCTC, adjusted transfer flow.
- 2025-09-23: Integrated RainbowKit + wagmi: added `RainbowProvider`, wrapped app, and added `ConnectButton` on homepage.
- 2025-09-23: Updated `CreditNameService` with 100 tCTC transfer fee and marketplace hook.
- 2025-09-23: Added `contracts/CreditNameMarketplace.sol` with 100 tCTC listing fee, buy/unlist flow.


