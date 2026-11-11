# NOVALAB — Requerimientos del ecosistema de 3 aplicaciones

**Versión:** 0.1 (borrador de arranque) · **Fecha:** octubre 2026
**Modelo de despliegue:** autoalojado, un negocio por instalación (Raspberry Pi o mini PC)

---

## 1. Resumen

NOVALAB es un sistema para negocios de impresión 3D que quieren controlar su producción, dar seguimiento a sus clientes y ver sus números. Se compone de **un solo backend** y **tres aplicaciones**, cada una con una tecnología de frontend distinta:

| # | Aplicación | Usuario | Frontend | Objetivo |
|---|-----------|---------|----------|----------|
| 1 | **Producción** | Dueño y operadores | **Flutter** (Web / tablet / escritorio) | Decidir qué impresora imprime qué pedido, gestionar la cola y los faltantes |
| 2 | **Seguimiento del cliente** | Cliente final (público, sin login) | **SvelteKit** (estático, PWA ligera) | Ver el estado del pedido tipo Mercado Libre, con cámara y guía de envío |
| 3 | **Finanzas** | Solo el dueño | **React + Vite + TypeScript** | Ver costos, ganancias, comparativa mensual y avance hacia la meta |
| — | **Backend único** | — | **FastAPI (Python) + SQLite** | API REST, tiempo real, integración con OctoPrint, cámaras, cola y cálculos |

**Por qué cada frontend:**

- **Flutter** para Producción: una sola base de código para web, tablet Android y escritorio; buen manejo de listas arrastrables y tiempo real. Es el stack que ya manejas.
- **SvelteKit** para el cliente: genera bundles muy pequeños, ideal para abrir un link desde WhatsApp en un celular con datos móviles.
- **React** para Finanzas: el ecosistema de gráficas y tablas de datos es el más maduro.

---

## 2. Arquitectura y despliegue

```
                    Internet
                       │
              Cloudflare Tunnel (solo puerto público)
                       │
┌──────────────────────┼─────────────── Raspberry Pi / mini PC ───────────────┐
│                      ▼                                                       │
│   Caddy :8080 (PÚBLICO)            Caddy :8081 (PRIVADO, solo LAN/VPN)       │
│   ├─ /            → App 2 Cliente  ├─ /admin      → App 1 Producción         │
│   └─ /api/public  → Backend        ├─ /finanzas   → App 3 Finanzas           │
│                                    └─ /api        → Backend (completo + WS)  │
│                          ▼                                                   │
│                  FastAPI + SQLite (WAL)  ──►  /data (db, snapshots, backups) │
│                          │                                                   │
└──────────────────────────┼───────────────────────────────────────────────────┘
                           ▼ (red local)
              OctoPrint de cada impresora  +  mjpg-streamer (snapshot)
```

**Decisiones clave:**

- **Dos puertos.** El puerto público solo expone la página del cliente y `/api/public/*`. El panel admin y finanzas solo se alcanzan desde la red local o una VPN. El túnel apunta únicamente al puerto público.
- **Acceso remoto del dueño (opcional):** Cloudflare Access (Zero Trust) delante del puerto privado, o VPN.
- **Empaquetado:** Docker Compose (backend, Caddy, cloudflared). Instalación con un comando; más adelante, imagen de SD lista para grabar.
- **Ejecución:** Pi 4 de 4 GB como mínimo. Si comparte la Pi con OctoPrint, medir carga; lo recomendado es una Pi o mini PC dedicada.

---

## 3. Backend único

### 3.1 Stack

- Python 3.12, **FastAPI**, Pydantic v2, SQLAlchemy 2 (o SQLModel)
- **SQLite** en modo WAL, migraciones con **Alembic**
- `httpx` (async) para hablar con OctoPrint; **APScheduler** o tareas asyncio para los pollers
- Autenticación: hash `argon2-cffi`, sesión con JWT de vida corta + refresh
- Límite de peticiones en endpoints públicos (`slowapi` o equivalente)
- **OpenAPI** generado automáticamente: es el contrato que consumen las 3 apps (ver sección 7)
- Pruebas con `pytest`

### 3.2 Módulos

`auth` · `orders` · `products` · `printers` · `queue` · `spools` · `shipping` · `finance` · `public` · `settings` · `realtime` · `backups`

### 3.3 Modelo de datos (un negocio por instalación, sin `org_id`)

| Tabla | Campos principales |
|-------|--------------------|
| `settings` (1 fila) | nombre del negocio, logo, colores, moneda, zona horaria, tarifa de luz (kWh), URL base de rastreo Estafeta, mostrar pie "Seguimiento por NOVALAB" |
| `users` | nombre, email, hash, rol (`owner` / `operator`), activo |
| `customers` | nombre, teléfono, email, notas |
| `products` | nombre, material, color, peso estimado (g), tiempo estimado (min), costo extra, archivo gcode opcional, precio base |
| `orders` | folio, cliente, estado, fecha de creación, **fecha prometida**, total, `tracking_token`, notas |
| `order_items` | pedido, producto, color, cantidad, **cantidad_impresa**, estado |
| `print_jobs` | item, impresora, estado, posición en cola, inicio, fin, gramos reales, minutos reales, motivo de falla |
| `printers` | nombre, URL OctoPrint, API key (cifrada), URL snapshot, tamaño de cama, estado, spool cargado |
| `spools` | material, color, diámetro, gramos iniciales, gramos restantes, **costo por kg** |
| `shipments` | pedido, paquetería, número de guía, fecha de envío, fecha de entrega |
| `expenses` | fecha, categoría (luz, empaque, envío, comisiones, mantenimiento, otro), monto, pedido opcional |
| `goals` | mes, meta de ganancia |
| `status_history` | entidad, id, estado anterior, estado nuevo, usuario, fecha |

### 3.4 Máquinas de estado

**Pedido (lo que ve el cliente):**

`Confirmado → En cola → Imprimiendo → Impreso → Empacado → Enviado → Entregado` (más `Cancelado`)

- `En cola`, `Imprimiendo` e `Impreso` se **derivan** del estado de los items del pedido.
- `Empacado`, `Enviado` y `Entregado` son transiciones manuales.
- Toda transición se guarda en `status_history` (de ahí sale la línea de tiempo del cliente).

**Item / print_job:** `Pendiente → En cola → Imprimiendo → Impreso` o `Fallido` (genera reimpresión y suma al costo de fallas).

### 3.5 Integración con OctoPrint

- **BE-01** Alta de impresora con nombre, URL y API key, y botón "probar conexión".
- **BE-02** Polling de `/api/job` y `/api/printer` cada ~5 s mientras imprime y cada ~30 s en reposo, con reintentos y estado "sin conexión".
- **BE-03** Datos expuestos al panel: estado, progreso %, tiempo restante, temperaturas, archivo actual.
- **BE-04** Al terminar un job, registrar tiempo real y descontar gramos del spool cargado.
- **BE-05** Enviar un gcode a la impresora y arrancarlo solo con **confirmación explícita del operador** ("cama libre"). Nunca iniciar impresiones de forma automática.
- **BE-06** Capa de **adaptadores** por tipo de impresora (v1: OctoPrint; después Klipper/Moonraker u otros).

### 3.6 Cámaras

- **BE-07** Mientras haya un job activo, el backend toma un snapshot (por ejemplo el `?action=snapshot` de mjpg-streamer) cada 10-15 s y guarda solo el último por impresora.
- **BE-08** El cliente recibe la imagen **a través del backend**; nunca se expone la IP ni el stream de la impresora.
- **BE-09** La cámara solo es visible para el pedido que tiene un item imprimiéndose en esa impresora.
- **BE-10** Video en vivo y timelapse quedan para una fase posterior.

### 3.7 Cola

- **BE-11 (manual):** asignar items a impresoras, reordenar, mover entre impresoras, pausar o quitar de la cola.
- **BE-12 (faltantes):** por pedido, `faltantes = cantidad − cantidad_impresa`; consulta global de todo lo pendiente por producto y color.
- **BE-13 (sugerencia):** el sistema propone una asignación y el operador acepta o modifica. Criterios:
  1. Urgencia (fecha prometida más cercana primero).
  2. Compatibilidad: material, color y diámetro cargados; tamaño de cama.
  3. Spool con gramos suficientes.
  4. Menos cambios de filamento.
  5. Balanceo de carga (repartir tiempo estimado entre impresoras).
- **BE-14** Cada sugerencia incluye una **explicación** ("va en la Impresora 2 porque ya tiene PETG negro y el pedido vence el viernes").
- **BE-15 (mejora posterior):** comparar tiempos estimados vs reales para afinar las estimaciones.

### 3.8 Finanzas (fórmulas)

- `costo_material = gramos_usados × (costo_por_kg_del_spool / 1000)`
- `costo_luz = horas_impresión × kW_impresora × tarifa_kWh`
- `costo_pedido = material + luz + empaque + envío + comisiones + otros`
- `ganancia_pedido = total_pedido − costo_pedido`
- `margen = ganancia / total`
- `costo_fallas` = material y luz de los jobs `Fallido` (se reporta aparte y suma al costo del mes)
- `variación_mensual = (ganancia_mes − ganancia_mes_anterior) / ganancia_mes_anterior`
- `faltante_meta = max(0, meta_mes − ganancia_mes)`
- **BE-16** El costo por kg es editable por spool (importante para filamento rPET propio, cuyo costo no es el de un proveedor).

### 3.9 API (resumen de endpoints)

**Públicos** (`/api/public/*`, sin login, con límite de peticiones)

- `GET /api/public/branding`
- `GET /api/public/track/{token}` — estado, línea de tiempo, items con progreso, envío
- `GET /api/public/track/{token}/camera` — último snapshot (solo si aplica)
- `POST /api/public/lookup` — folio + últimos 4 dígitos del teléfono → devuelve el token

**Privados** (`/api/*`, requieren login)

- `auth`: login, refresh, logout, gestión de usuarios (solo `owner`)
- `orders`: CRUD, transiciones de estado, items, historial
- `products`, `customers`, `spools`, `expenses`, `goals`, `settings`
- `printers`: CRUD, probar conexión, estado en vivo
- `queue`: ver, reordenar, `POST /queue/suggest`, `POST /queue/accept`
- `print-jobs`: confirmar inicio, marcar terminado o fallido
- `shipments`: guía, fechas
- `finance`: `GET /finance/summary?month=YYYY-MM`, `/finance/orders`, `/finance/trend`, `/finance/products`
- `WS /ws`: eventos en tiempo real (estado de impresoras, cola, pedidos)

### 3.10 Seguridad

- **BE-17** Roles: `owner` (todo, incluido finanzas) y `operator` (producción, sin finanzas ni usuarios).
- **BE-18** `tracking_token` aleatorio y largo (por ejemplo `secrets.token_urlsafe(24)`); nunca el folio secuencial.
- **BE-19** Límite de intentos en login y en `lookup`.
- **BE-20** API keys de OctoPrint cifradas en reposo.
- **BE-21** La respuesta pública **nunca** incluye costos, ganancias, datos de otros clientes ni IPs internas.
- **BE-22** Página pública con `noindex` y sin datos personales innecesarios (solo nombre de pila).

### 3.11 Operación

- **BE-23 Respaldos:** copia nocturna con `sqlite3 .backup` a `/data/backups`, conservar 14, con destino opcional a USB o nube del negocio.
- **BE-24 Migraciones:** Alembic automáticas al arrancar.
- **BE-25 Actualizaciones:** comando `novalab update` (baja imágenes, respalda, migra, reinicia) y endpoint `/api/version`.
- **BE-26 Observabilidad:** logs estructurados, endpoint `/health`, aviso en el panel si una impresora lleva tiempo sin conexión.

### 3.12 No funcionales

- Soportar al menos 10 impresoras y decenas de miles de pedidos en una Pi 4.
- Respuesta p95 menor a 300 ms en consultas normales.
- Textos externalizados (idioma por defecto `es-MX`), zona horaria y moneda configurables.

---

## 4. App 1 — Producción (Flutter)

**Usuarios:** dueño y operadores · **Dispositivos:** navegador de escritorio, tablet en el taller, escritorio Linux
**Tecnología:** Flutter (Web como destino principal), Riverpod (estado), go_router, `dio` con cliente generado desde OpenAPI, `web_socket_channel` para tiempo real, `ReorderableListView` / drag and drop para la cola.

### Requerimientos funcionales

- **P-01** Login y cierre de sesión; sesión persistente en el dispositivo.
- **P-02** **Tablero de impresoras:** una tarjeta por impresora con estado, progreso, tiempo restante, temperaturas, miniatura de cámara, spool cargado y pedido actual. Actualización en vivo.
- **P-03** **Cola:** columnas por impresora más una columna "sin asignar"; arrastrar items entre columnas y reordenar.
- **P-04** Botón **"Sugerir asignación"**: muestra la propuesta con su explicación y permite aceptar todo, aceptar parcial o descartar.
- **P-05** **Iniciar impresión** con diálogo de confirmación ("¿cama libre y filamento correcto?").
- **P-06** Marcar job como terminado o fallido (con motivo) y ofrecer reimpresión.
- **P-07** **Pedidos:** lista con filtros (estado, fecha prometida, cliente), búsqueda por folio, y alertas visuales de pedidos próximos a vencer.
- **P-08** **Detalle de pedido:** items, progreso por item, **faltantes**, impresora asignada, historial de estados, y cambio manual de estado (empacado, enviado, entregado).
- **P-09** **Nuevo pedido:** cliente, productos, cantidades, colores, fecha prometida, total. Copiar el link de seguimiento al portapapeles con un toque.
- **P-10** **Faltantes globales:** vista de todo lo pendiente por producto y color, y a qué pedido pertenece cada pieza.
- **P-11** **Inventario de filamento:** spools con gramos restantes, color, costo por kg y alerta de poco material.
- **P-12** **Productos:** catálogo con peso, tiempo, material y gcode opcional.
- **P-13** **Impresoras:** alta, edición, prueba de conexión, URL de cámara.
- **P-14** **Envíos:** capturar paquetería y guía, y abrir el rastreo de Estafeta.
- **P-15** **Ajustes:** datos y marca del negocio (logo, colores), tarifa de luz, usuarios (solo `owner`).

### No funcionales

- Usable con una mano y botones grandes en tablet.
- Reconexión automática del WebSocket y aviso visible cuando no hay conexión.
- Tema por defecto con la identidad NOVALAB, reemplazable por la marca del negocio.

### Criterios de aceptación

- Mover un item a otra impresora se refleja en menos de 2 s en otro dispositivo abierto.
- Con una impresora desconectada, el tablero lo indica sin romper el resto de la pantalla.

---

## 5. App 2 — Seguimiento del cliente (SvelteKit)

**Usuario:** cliente final, desde el celular, sin crear cuenta · **Acceso:** link único por pedido (`/p/{token}`)
**Tecnología:** SvelteKit con `adapter-static`, TypeScript, CSS con variables de tema (sin framework pesado). PWA ligera opcional.

### Requerimientos funcionales

- **C-01** Página `/p/{token}` con **encabezado de marca** del negocio (logo, nombre, colores).
- **C-02** **Línea de tiempo** del pedido: Confirmado, En cola, Imprimiendo, Impreso, Empacado, Enviado, Entregado, con fecha y hora de cada paso y el paso actual resaltado.
- **C-03** **Items del pedido** con progreso ("3 de 5 piezas impresas").
- **C-04** **Cámara:** mientras el pedido se está imprimiendo, mostrar la última imagen de la impresora con "actualizado hace X s" y refresco automático cada 10-15 s. Si no hay impresión activa, mostrar un mensaje claro en lugar de la cámara.
- **C-05** **Envío:** paquetería, número de guía y botón "Rastrear en Estafeta" (URL configurable).
- **C-06** **Fecha estimada de entrega** (basada en la fecha prometida).
- **C-07** **Consulta manual** en la página de inicio: folio + últimos 4 dígitos del teléfono, para quien perdió el link.
- **C-08** Actualización automática del estado por polling cada ~15 s mientras la pestaña esté visible.
- **C-09** Pie discreto "Seguimiento por NOVALAB" (obligatorio o configurable según la licencia).
- **C-10** Mensajes de error amables: pedido no encontrado, link inválido, demasiados intentos.

### No funcionales

- Bundle menor a ~100 KB comprimido; carga en menos de 2 s en 4G.
- Diseño mobile-first, contraste accesible y textos legibles al sol.
- `noindex`; sin cookies de rastreo ni analítica de terceros.
- No se muestran precios internos, costos ni datos de otros pedidos (ver BE-21).

### Criterios de aceptación

- Abrir el link desde WhatsApp en un celular de gama baja y ver el estado correcto sin iniciar sesión.
- Un token inválido o de otro pedido nunca muestra información.

---

## 6. App 3 — Finanzas (React + Vite + TypeScript)

**Usuario:** solo `owner` · **Acceso:** puerto privado (LAN/VPN/Cloudflare Access)
**Tecnología:** React, Vite, TypeScript, TanStack Query (datos), React Router, **Recharts** (gráficas), Tailwind CSS (opcionalmente shadcn/ui), cliente tipado generado desde OpenAPI.

### Requerimientos funcionales

- **F-01** Login con verificación de rol `owner`; un `operator` no puede entrar.
- **F-02** **Resumen del mes:** número de pedidos, ingresos, costos, ganancia y margen.
- **F-03** **Comparativa con el mes anterior** en porcentaje, con indicador de subida o bajada (por ejemplo "+20 %").
- **F-04** **Meta mensual:** barra de progreso, monto alcanzado y **cuánto falta** ("faltan $1,000 para tu meta").
- **F-05** **Tabla de pedidos** del periodo con ingreso, desglose de costos (material, luz, empaque, envío, comisiones, otros), ganancia y margen; ordenable y filtrable.
- **F-06** **Tendencia** de los últimos 12 meses (ingresos vs costos vs ganancia).
- **F-07** **Rentabilidad por producto:** cuáles dejan más margen y cuáles menos.
- **F-08** **Costo de fallas:** gramos y dinero perdidos en impresiones fallidas, por mes.
- **F-09** **Gastos:** alta, edición y baja con categorías; asignación opcional a un pedido.
- **F-10** **Configuración de la meta** por mes y de la tarifa de luz.
- **F-11** **Exportar a CSV** de pedidos y gastos del periodo.
- **F-12** Selector de periodo (mes, rango personalizado).

### No funcionales

- Los cálculos viven en el backend; el frontend solo presenta (una sola fuente de verdad para las fórmulas).
- Cifras con formato de moneda configurado en `settings`.
- Gráficas legibles en escritorio y en celular.

### Criterios de aceptación

- Las cifras de un mes de prueba coinciden con un cálculo manual en hoja de cálculo.
- Un usuario `operator` recibe 403 en cualquier endpoint de `finance`.

---

## 7. Contrato compartido y marca

- **Fuente única de verdad:** el esquema **OpenAPI** del backend. De él se generan los clientes tipados de las 3 apps (Dart para Flutter, TypeScript para Svelte y React).
- **Tokens de diseño compartidos** (colores, tipografías, espaciados) en un paquete común, exportados a las 3 tecnologías.
- **Tema por defecto (instancia NOVALAB):** Midnight Blue `#0B132B`, Neon Green `#00FF87`, Blanco. Cada negocio puede cambiar logo y colores desde `settings`; las 3 apps leen `GET /api/public/branding`.
- **Textos:** archivo de cadenas por idioma, `es-MX` por defecto.

---

## 8. Estructura del repositorio (monorepo)

```
novalab/
├─ backend/                 # FastAPI, Alembic, tests
├─ apps/
│  ├─ produccion/           # Flutter
│  ├─ cliente/              # SvelteKit
│  └─ finanzas/             # React + Vite
├─ packages/
│  └─ design-tokens/        # colores, tipografías, espaciados
├─ deploy/
│  ├─ docker-compose.yml
│  ├─ Caddyfile
│  └─ install.sh
└─ docs/                    # este documento, guías de instalación
```

---

## 9. Roadmap por fases

| Fase | Entregable | Criterio de salida |
|------|-----------|--------------------|
| 0 | Monorepo, Docker Compose, Caddy, FastAPI, SQLite, login, OpenAPI | Se levanta todo con un comando en la Pi |
| 1 | Pedidos, clientes, productos + **App 2 (tracking)** con marca blanca | Un pedido real se sigue desde un celular |
| 2 | **App 1** cola manual, faltantes, inventario de filamento | Se opera la producción de NOVALAB desde el panel |
| 3 | Integración OctoPrint + snapshots de cámara | El cliente ve la cámara de su pedido en vivo (snapshots) |
| 4 | **App 3 (finanzas)** | Cifras del mes coinciden con el cálculo manual |
| 5 | Cloudflare Tunnel, instalador, respaldos, `novalab update` | Instalación limpia en una segunda Pi sin ayuda |
| 6 | **Beta** con 1-2 negocios | Feedback real y lista de ajustes |
| 7 | Sugerencias inteligentes de cola | El operador acepta la mayoría de las sugerencias |
| 8 | Adaptadores extra (Klipper, otras marcas), licenciamiento | — |

---

## 10. Fuera de alcance en la v1

- Pagos en línea, carrito o tienda en línea.
- Integración por API con Estafeta (v1: guía manual y enlace de rastreo).
- Notificaciones push, WhatsApp o correo automáticos.
- Video en vivo y timelapse para el cliente.
- Inicio automático de impresiones sin confirmación del operador.
- Multi-sucursal dentro de una misma instalación.

---

## 11. Riesgos y decisiones abiertas

**Riesgos**

1. **Tres tecnologías de frontend** multiplican el mantenimiento y el soporte. Mitigación: OpenAPI como contrato, tokens de diseño compartidos, monorepo y que la lógica de negocio (cálculos, cola, estados) viva solo en el backend.
2. **Soporte a instalaciones ajenas** (actualizaciones, redes distintas, fallas de hardware). Mitigación: instalador y actualizador sólidos desde la fase 5, respaldos automáticos y logs claros.
3. **Seguridad del puerto público.** Mitigación: Tunnel solo al puerto público, tokens largos, límites de intentos, respuesta pública mínima.
4. **Pi saturada** si comparte equipo con OctoPrint, webcams y timelapse. Mitigación: Pi dedicada o mini PC; medir antes de decidir.

**Decisiones abiertas**

- ¿Un pedido cuenta para las finanzas en la fecha de **confirmación**, de **pago** o de **entrega**? (Afecta la comparativa mensual.)
- ¿El pie "Seguimiento por NOVALAB" será obligatorio en todas las instalaciones o solo en una versión gratuita?
- Modelo de comercialización: licencia, suscripción de soporte, kit "NOVALAB Box" con la Pi preconfigurada, u otro.
- Dominio y túnel: ¿lo configura cada negocio o NOVALAB ofrece subdominios?
- Método para obtener gramos y tiempo estimado por producto: captura manual en v1; lectura automática desde el gcode después.