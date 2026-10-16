# apps/produccion

App de producción de NOVALAB (Flutter: web, tablet y escritorio). Presenta, no
calcula: la lógica de negocio vive en el backend (ver `AGENTS.md`).

## Estado

Rebanada vertical **P-01..P-03** contra `packages/api-contract/openapi.yaml`:

- **P-01** Login/logout con sesión persistente (`SharedPreferences`).
- **P-02** Tablero de impresoras en vivo: estado, progreso, tiempo restante,
  temperaturas, miniatura de cámara, spool y pedido actual. Tiempo real por
  `/ws` (mock incluido).
- **P-03** Cola: columnas por impresora + "sin asignar", arrastrar y reordenar.

El backend aún no existe: por defecto la app usa un backend simulado
(`USE_MOCKS=true`).

## Requisitos

- Flutter 3.44+ / Dart 3.12+
- Java 21 (solo para regenerar el cliente con `openapi_generator`)

## Comandos (workdir `apps/produccion`)

```
flutter analyze
flutter test
flutter run -d chrome
flutter build web --release
flutter build linux
```

Opciones de entorno vía `--dart-define`:

```
flutter run -d chrome --dart-define=USE_MOCKS=false --dart-define=API_BASE_URL=http://localhost:8081
```

## Credenciales de demostración (mock)

Cualquier contraseña `novalab`:

- `dueno@novalab.mx` (owner)
- `operador@novalab.mx` (operator)

## Contrato y cliente generado

- Contrato único: `packages/api-contract/openapi.yaml`.
- Cliente Dart/dio generado en `packages/api_client` (pubName `novalab_api`).
  **No editar a mano.**

Regenerar tras cambiar el contrato:

```
flutter pub run build_runner build
```

`lib/src/api/openapi_config.dart` usa `forceAlwaysRun: true` porque el spec vive
fuera del package y `build_runner` no detecta sus cambios por sí solo.

## Estructura

```
lib/
  core/
    api/        cliente dio, interceptores (auth, mock) y backend simulado
    branding/   marca del negocio (GET /api/public/branding)
    config/     AppConfig (--dart-define) y providers base
    i18n/       AppStrings (es-MX) y AppFormatters
    realtime/   canal /ws (WebSocket real + mock)
    router/     go_router con guardia de sesión
    theme/      tokens de diseño y tema desde la marca
  features/
    auth/       P-01: estado, controlador y pantalla de login
    printers/   P-02: proveedores y tarjetas del tablero
    queue/      P-03: cola con arrastrar y reordenar
    dashboard/  contenedor con navegación responsiva
```

## Pruebas

`flutter test` cubre login/sesión, tablero (con canal en vivo controlado),
cola (mover items), formateo es-MX y navegación responsiva. La latencia del mock
se desactiva en pruebas con `mockLatencyProvider`.
# novalab-3-apps-proyect
