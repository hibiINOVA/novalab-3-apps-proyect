# AGENTS.md

## Source of truth

- Functional truth: `Novalab requerimientos.md` (v0.1, es-MX). If code contradicts docs, **code wins**.
- Contract: `packages/api-contract/openapi.yaml`. Typed clients generated from it; never duplicate types or calculations.
- Requirements IDs: cite `BE-xx`, `P-xx`, `C-xx`, `F-xx` when working.

## Repo state

- Monorepo by folders: `Producción/`, `Seguimiento del cliente/` (planned), `Finanzas/` (planned), `Backend único/`, `packages/`, `deploy/` (planned), `docs/` (planned).
- `Producción/` (Flutter): **P-01..P-04** + orders + organizations. `Backend único/` (FastAPI) implements all contract endpoints + seed demo.
- `Producción/` runs against mocks by default (`USE_MOCKS=true`); point `API_BASE_URL` at backend to go live.
- No CI yet. Generated Dart client is in `packages/api_client` (do not edit manually).
- `Producción/lib/src/api/openapi_config.dart` uses `@Openapi(forceAlwaysRun: true)` because spec lives outside the package.
- **`Producción/README.md` is stale** (claims backend doesn't exist, workdir `apps/produccion`). Trust this file and the code, not that README.

## Entry points & boundaries

- **Producción/**: Flutter (web/tablet/desktop), `lib/core/` (api/branding/config/i18n/realtime/router/theme) + `lib/features/` (auth P-01, printers P-02, queue P-03, orders, organization, dashboard shell). Riverpod + go_router. Mock backend: `lib/core/api/mock/mock_backend.dart`.
- **packages/api-contract/openapi.yaml**: single OpenAPI contract; generates `packages/api_client` (Dart/dio, pubName `novalab_api`).
- **packages/api_client**: generated output — never edit. Regenerate from contract (Java 21 required, only for this).
- **Backend único/**: FastAPI + SQLite + Alembic. Business logic, state machines, queue rules, and **all finance formulas** live only there. Routers: auth, catalog, orders, organizations, printers, print_jobs, public, queue, ws.
- **Seguimiento del cliente/** (planned): SvelteKit static (public, anonymous — only sees own `tracking_token`). **Must not** expose costs/profits/other clients/internal IPs (public tracking app).
- **Finanzas/** (planned): React + Vite + TS (private). Finance calculations come from backend.
- **deploy/** (planned): docker-compose, Caddyfile, install.sh.
- **docs/** (planned).

## Commands (exact)

Run Flutter commands from `Producción/` (workdir):

```bash
flutter analyze                 # lint + types
flutter test                    # unit + widget tests
flutter run -d chrome           # dev
flutter build web --release     # web build
flutter build linux             # desktop build
flutter pub run build_runner build --delete-conflicting-outputs  # regenerate client from OpenAPI (~1 min)
dart format lib test            # format before commit
```

Run backend commands from `Backend único/` (workdir):

```bash
source .venv/bin/activate       # venv (already created)
uvicorn app.main:app --port 8081   # dev server (auto-creates tables + seed)
python -m pytest tests/ -q      # 38 tests
alembic upgrade head            # apply migrations (fresh DBs only)
```

Env/config via `--dart-define`: `API_BASE_URL`, `USE_MOCKS` (defaults `true`).

Backend env vars use prefix `NOVALAB_` (see `app/config.py`), e.g. `NOVALAB_DB_URL`, `NOVALAB_SEED_DEMO`.

Demo creds (mock + backend seed, password `novalab`): `dueno@novalab.mx` (owner), `operador@novalab.mx` (operator).

## Critical invariants

- Business logic (state machines, queue/missing parts, **all finance formulas**) lives only in `Backend único/`. Frontends present only.
- OpenAPI is the single contract. Generate typed clients for all 3 apps (Dart/TS). Don't duplicate types/calculations.
- **Two-port topology** (planned): public serves only `Seguimiento del cliente/` + `/api/public/*`; private (LAN/VPN/Cloudflare Access) serves `Producción/` (`/admin`), `Finanzas/` (`/finanzas`), full `/api` + WebSocket.
- Public API never exposes costs, profits, other clients, or internal IPs (BE-21, BE-22). Client is anonymous, only sees own `tracking_token`.
- Never auto-start prints: sending G-code requires explicit operator confirmation (BE-05, P-05).
- Single-tenant operativo: printers/orders/queue/costos no llevan `org_id` (un negocio por instalación). Las **organizaciones** (`/api/organizations*`) solo gestionan membresías owner/operador; no aíslan datos del negocio.
- Camera served via backend snapshot only (no raw stream/IP exposure) (BE-08).
- Defaults: `es-MX`, texts externalized, currency/timezone configurable (doc §3.12, §7). Branding from `GET /api/public/branding`.

## Testing notes

- `flutter test` in `Producción/` covers auth/session, live dashboard (controlled WS), queue drag/reorder, suggestion dialog, organization flow, es-MX formatting, responsive nav.
- Mock latency disabled in tests via `mockLatencyProvider`.
- `python -m pytest tests/` in `Backend único/` covers auth, queue version 409, jobs lifecycle, orders/status, public track/lookup, finance formulas, WS hello, organizations (create/join/approve/reject/update/members/logo), printer CRUD, customers, gcode upload.

## Conventions

- One commit per step, Conventional Commits (type in English, description in Spanish).
- Before committing: from `Producción/`, run `dart format lib test && flutter analyze && flutter test` (when touching that app).
- Never edit `packages/api_client` manually. Contract is `packages/api-contract/openapi.yaml`; if contract changes, regenerate (from `Producción/` as shown above, or per target app).
- Read `Novalab requerimientos.md` for behavioral details; cite requirement IDs in work.

## Out of scope (v1)

Payments/storefront, Estafeta API (manual label/link only), push/WhatsApp/email, live video/timelapse, auto-start prints, multi-location (doc §10).