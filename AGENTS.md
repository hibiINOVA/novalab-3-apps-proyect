# AGENTS.md

## Estado del repositorio

La fuente de verdad funcional es `Novalab requerimientos.md` (v0.1, es-MX); si el código la contradice, gana el código.

Hoy existe la **rebanada vertical P-01..P-03 de `apps/produccion`** (Flutter), contract-first contra `packages/api-contract/openapi.yaml`, con cliente Dart generado en `packages/api_client`. El backend **aún no existe**: la app corre contra un backend simulado (`USE_MOCKS=true` por defecto). No hay CI todavía.

### Comandos de `apps/produccion` (ejecutar con workdir `apps/produccion`)

```
flutter analyze                 # lint + tipos
flutter test                    # pruebas (unit y widget)
flutter run -d chrome           # desarrollo en navegador
flutter build web --release     # build de entrega web
flutter build linux             # build de escritorio
flutter pub run build_runner build   # regenerar cliente desde el OpenAPI (~1 min)
```

Reglas de trabajo:
- Un commit por paso, Conventional Commits (tipo en inglés, descripción en español).
- Antes de commitear: `dart format lib test`, `flutter analyze`, `flutter test`.
- No editar a mano `packages/api_client` (código generado). El contrato vive en `packages/api-contract/openapi.yaml`; el spec está fuera del package, así que `openapi_config.dart` usa `forceAlwaysRun: true` para forzar la regeneración.

Credenciales demo del mock (cualquier contraseña `novalab`): `dueno@novalab.mx` (owner) u `operador@novalab.mx` (operator). Config vía `--dart-define`: `API_BASE_URL`, `USE_MOCKS`.

## Qué es NOVALAB

Un backend y tres frontends para negocios de impresión 3D, autoalojado (una instalación = un negocio = una Raspberry Pi/mini PC). Los requerimientos usan IDs (`BE-xx` backend, `P-xx` producción, `C-xx` cliente, `F-xx` finanzas); cítalos al trabajar.

Estructura planeada (monorepo):

```
backend/            FastAPI + SQLite + Alembic + pytest
apps/produccion/    Flutter (web/tablet/escritorio)
apps/cliente/       SvelteKit adapter-static (público, sin login)
apps/finanzas/      React + Vite + TypeScript
packages/design-tokens/
deploy/             docker-compose.yml, Caddyfile, install.sh
docs/
```

## Invariantes que un agente rompería sin saberlo

- **La lógica de negocio vive solo en el backend**: máquinas de estado, cola/faltantes y **todas las fórmulas de finanzas**. Los frontends solo presentan (doc §3.8, §6 no funcionales).
- **OpenAPI es el contrato único.** De él se generan los clientes tipados de las 3 apps (Dart y TypeScript). No dupliques tipos ni cálculos a mano.
- **Dos puertos**: el público solo sirve `apps/cliente` + `/api/public/*`; producción (`/admin`), finanzas (`/finanzas`) y `/api` completo (+ WebSocket) son privados (LAN/VPN/Cloudflare Access) (doc §2).
- **La API pública nunca expone costos, ganancias, otros clientes ni IPs internas** (BE-21, BE-22). El cliente final es anónimo y solo ve datos de su propio `tracking_token`.
- **Nunca iniciar impresiones automáticamente**: el envío de gcode requiere confirmación explícita del operador (BE-05, P-05).
- **Sin `org_id`**: un negocio por instalación. No agregues multi-tenant.
- **La cámara se sirve a través del backend** (snapshot), nunca se expone el stream ni la IP de la impresora (BE-08).
- **Idioma por defecto `es-MX`**; textos externalizados, moneda y zona horaria configurables (doc §7, §3.12).
- Marcas y colores por negocio se leen de `GET /api/public/branding`.

## Fuera de alcance en v1 (no lo implementes)

Pagos/tienda en línea, API de Estafeta (solo guía manual + link), notificaciones push/WhatsApp/email, video en vivo/timelapse, inicio automático de impresiones, multi-sucursal (doc §10).
