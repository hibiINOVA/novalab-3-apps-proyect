# Deploy en Raspberry Pi — desde cero

Procedimiento completo para levantar NOVALAB en una Pi limpia: backend + front + túnel público + auto-deploy. Cita `BE-01`…`BE-26` (integración impresora en `setup-raspberry-pi-ender3.md`).

**Topology final**

| Componente | Puerto | Ruta/servicio |
|---|---|---|
| Backend (uvicorn) | `8083` (localhost en prod; `0.0.0.0` en la Pi actual) | svc `novalab-backend` (o el uvicorn manual actual) |
| nginx (3 fronts + proxy) | `8091` (0.0.0.0) | `/` → `/var/www/novalab` (Flutter), `/finanzas/` → `/var/www/novalab-finanzas/`, `/seguimiento/` → `/var/www/novalab-seguimiento/`; `/api/*`, `/ws`, `/health`, `/docs`, `/openapi.json` → `127.0.0.1:8083` |
| Cloudflared tunnel | — | `novalab-tunnel.service` → `http://127.0.0.1:8091` (URL efímera) |
| Hub público (portal) | 443 | GitHub Pages `https://hibiinova.github.io/novalab/` lee `url.txt` y ofrece los 3 accesos: Producción, Finanzas, Seguimiento |
| Auto-deploy | cada 120 s | `novalab-deploy.timer` → `/opt/novalab/auto-deploy.sh` (solo en layout `/opt/novalab`; ver §6) |
| OctoPrint (opcional) | `5000` | ver `docs/setup-raspberry-pi-ender3.md` |

> **Puertos ocupados en la Pi `ender3`**: `8080`/`8081` = ustreamer (cámaras), `8090` = `youtube_live.py`. Por eso el backend NOVALAB corre en **`8083`**.

**Layout en la Pi**

```
/opt/novalab/
├── app-repo/          # git clone del monorepo (origen del auto-deploy)
├── backend/           # runtime backend (rsync desde app-repo/Backend único/)
│   ├── .venv/
│   └── app/…
├── data/              # BD SQLite + snapshots (excluido del rsync)
│   └── novalab.db
├── backend.env        # variables NOVALAB_* (permisos 600)
├── auto-deploy.sh
└── .ssh/repo_ed25519  # deploy key para pull por SSH
/var/www/novalab/            # front Producción (Flutter) — raíz `/`
/var/www/novalab-finanzas/   # front Finanzas (React)  — `/finanzas/`
/var/www/novalab-seguimiento/# front Seguimiento (SvelteKit) — `/seguimiento/`
/home/hibi/.novalab-hub-token  # PAT de GitHub para sync del hub (600)
/home/hibi/sync-hub-url.sh     # actualiza url.txt del hub (ExecStartPost del túnel)
```

> **Layout real actual (Pi `ender3`)**: el backend corre desde `/home/hibi/novalab-3-apps-proyect/Backend único/` (uvicorn manual en `:8083`), no desde `/opt/novalab`. El procedimiento de abajo es el layout "limpio" objetivo; el runtime actual funciona igual con los mismos artefacts.

---

## 0. Requisitos

- Raspberry Pi 4 (2 GB+) con **Raspberry Pi OS Lite 64-bit**, red LAN, SSH.
- Cuenta de GitHub con acceso de escritura a `hibiINOVA/novalab-3-apps-proyect`.
- `cloudflared` instalado (paso 5).
- Credenciales demo tras el seed: `dueno@novalab.mx` / `operador@novalab.mx`, password `novalab`.
- Si usarás impresora + cámaras: completa antes `docs/setup-raspberry-pi-ender3.md` §1–§3.

## 1. Sistema base y usuario

```bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y git curl rsync nginx python3-venv python3-pip openssh-client
sudo reboot   # tras upgrade
```

Crea el usuario de servicio (si no existe) y dale SSH:

```bash
# desde tu máquina local, genera la deploy key del repo
ssh-keygen -t ed25519 -f repo_ed25519 -N "" -C "novalab-deploy"
# sube la pública a GitHub → Settings → Deploy keys → Add (Read & Write)
```

## 2. Clonar el repo

```bash
sudo mkdir -p /opt/novalab && sudo chown $USER /opt/novalab
mkdir -p /opt/novalab/.ssh
# copia la clave privada generada:
# scp repo_ed25519 hibi@<PI>:/opt/novalab/.ssh/repo_ed25519
chmod 700 /opt/novalab/.ssh && chmod 600 /opt/novalab/.ssh/repo_ed25519

GIT_SSH_COMMAND="ssh -i /opt/novalab/.ssh/repo_ed25519 -o IdentitiesOnly=yes" \
  git clone git@github.com:hibiINOVA/novalab-3-apps-proyect.git /opt/novalab/app-repo
```

## 3. Backend

```bash
rsync -a --exclude '.venv' --exclude 'data/' --exclude '__pycache__' \
  --exclude '*.db' --exclude '*.egg-info' \
  "/opt/novalab/app-repo/Backend único/" /opt/novalab/backend/

cd /opt/novalab/backend
python3 -m venv .venv
.venv/bin/pip install -q -e .
```

### Variables de entorno — `/opt/novalab/backend.env` (600)

```bash
SK=$(.venv/bin/python -c "import secrets;print(secrets.token_urlsafe(48))")
JS=$(.venv/bin/python -c "import secrets;print(secrets.token_urlsafe(48))")
umask 077
cat > /opt/novalab/backend.env <<EOF
NOVALAB_SECRET_KEY=$SK
NOVALAB_JWT_SECRET=$JS
NOVALAB_DB_URL=sqlite:////opt/novalab/data/novalab.db
NOVALAB_SEED_DEMO=true
NOVALAB_POLLER_ENABLED=true
EOF
mkdir -p /opt/novalab/data/snapshots
```

> `NOVALAB_SECRET_KEY` cifra las API keys de impresora en BD (BE-20). Si se pierde, hay que volver a guardar las API keys.

### Migraciones + prueba

```bash
cd /opt/novalab/backend
.venv/bin/alembic upgrade head     # crea tablas + seed demo + backfill multi-tenant (0005)
.venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8083 &
curl -s http://127.0.0.1:8083/health   # {"status":"ok","version":"0.1.0"}
```

### Servicio systemd — `/etc/systemd/system/novalab-backend.service`

(Disponible en `deploy/pi/novalab-backend.service`.)

```bash
sudo cp deploy/pi/novalab-backend.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-backend
systemctl is-active novalab-backend   # active
```

## 4. Fronts + nginx (3 apps en subpaths)

nginx sirve las 3 apps en un mismo origen (`:8091`):

| URL | App | Build en repo | Destino en la Pi |
|---|---|---|---|
| `/` | Producción (Flutter) | `deploy/web/` | `/var/www/novalab/` |
| `/finanzas/` | Finanzas (React) | `Finanzas/dist/` | `/var/www/novalab-finanzas/` |
| `/seguimiento/` | Seguimiento (SvelteKit) | `Seguimiento del cliente/build/` | `/var/www/novalab-seguimiento/` |

Los base paths están en el código: `Finanzas/vite.config.ts` (`base: "/finanzas/"`), `Finanzas/src/router.tsx` (`basename: "/finanzas"`), `Seguimiento del cliente/svelte.config.js` (`kit.paths.base = '/seguimiento'`).

```bash
# Producción (build de producción vive en el repo: deploy/web/)
sudo rsync -a --delete /opt/novalab/app-repo/deploy/web/ /var/www/novalab/

# Finanzas (build local, sin commitear dist/)
cd Finanzas && npm run build
sudo rsync -a --delete dist/ /var/www/novalab-finanzas/

# Seguimiento (build local, sin commitear build/)
cd "Seguimiento del cliente" && npm run build
sudo rsync -a --delete build/ /var/www/novalab-seguimiento/

sudo cp deploy/pi/nginx-novalab.conf /etc/nginx/sites-available/novalab
sudo ln -sf /etc/nginx/sites-available/novalab /etc/nginx/sites-enabled/novalab
sudo nginx -t && sudo systemctl reload nginx
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/               # 200 (Producción)
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/finanzas/      # 200
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/seguimiento/   # 200
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/health        # 200 (proxy)
```

Rebuild del front Producción cuando cambie `Producción/` (desde tu máquina local):

```bash
cd Producción && flutter build web --release
rsync -a --delete build/web/ ../deploy/web/
git add ../deploy/web && git commit -m "chore(web): rebuild front" && git push
# el auto-deploy de la Pi lo sincroniza solo (≤2 min)
```

> Finanzas y Seguimiento **no** pasan por auto-deploy (sus `dist/`/`build/` no se commitean): se rsync-ean manualmente tras cada build.

## 5. Túnel público (Cloudflared)

```bash
# instalar cloudflared (binario oficial)
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt update && sudo apt install -y cloudflared
```

Servicio — `deploy/pi/novalab-tunnel.service` (incluye `ExecStartPost` que sincroniza el hub):

```bash
sudo cp deploy/pi/novalab-tunnel.service /etc/systemd/system/
sudo cp deploy/pi/sync-hub-url.sh /home/hibi/sync-hub-url.sh && sudo chmod +x /home/hibi/sync-hub-url.sh
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-tunnel
sleep 12
journalctl -u novalab-tunnel --no-pager | grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' | head -1
```

### Hub público (GitHub Pages) + auto-sync de la URL

El hub `https://hibiinova.github.io/novalab/` (repo `hibiINOVA/novalab`, distinto al monorepo) es un **portal con 3 accesos**: Producción (`/`), Finanzas (`/finanzas/`), Seguimiento (`/seguimiento/`). Lee `url.txt` con la URL vigente del túnel (3 fallback sources: Pages, API GitHub con CORS, raw).

La URL se publica **automáticamente**: `deploy/pi/sync-hub-url.sh` corre como `ExecStartPost` del túnel, espera la URL nueva en el journal y hace PUT a `url.txt` vía GitHub API si cambió. Requiere un PAT con `contents:write` en `/home/hibi/.novalab-hub-token` (chmod 600):

```bash
# desde tu máquina local — crear el token una sola vez
umask 077 && echo "<PAT>" > /home/hibi/.novalab-hub-token   # en la Pi
```

Sync manual (si quieres forzarlo):

```bash
/home/hibi/sync-hub-url.sh
```

## 6. Auto-deploy (GitHub → Pi, cada 2 min)

Copia `deploy/pi/auto-deploy.sh` y los units:

```bash
sudo cp deploy/pi/auto-deploy.sh /opt/novalab/auto-deploy.sh
sudo chmod +x /opt/novalab/auto-deploy.sh
sudo cp deploy/pi/novalab-deploy.service deploy/pi/novalab-deploy.timer /etc/systemd/system/
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart novalab-backend, /usr/bin/systemctl reload nginx" | sudo tee /etc/sudoers.d/novalab-deploy
sudo chmod 440 /etc/sudoers.d/novalab-deploy
sudo visudo -cf /etc/sudoers.d/novalab-deploy   # OK
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-deploy.timer
systemctl list-timers | grep novalab-deploy
```

El script hace `git fetch/pull` con la deploy key, detecta cambios con `git -c core.quotepath=false diff --name-only` (importante: rutas con `Backend único/` tienen no-ASCII) y:

- `deploy/web/**` → rsync a `/var/www/novalab/` + `reload nginx`
- `Backend único/**` → rsync a `/opt/novalab/backend/` (+ `pip install -e` si cambió `pyproject.toml`) → `alembic upgrade head` → `restart novalab-backend`

Prueba forzada:

```bash
sudo systemctl start novalab-deploy.service
journalctl -u novalab-deploy.service --no-pager -n 10
```

## 7. Verificación final

```bash
# backend
curl -s http://127.0.0.1:8083/health                          # {"status":"ok",…}
# 3 fronts + proxy
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/               # 200
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/finanzas/      # 200
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/seguimiento/   # 200
# login demo vía proxy
curl -s http://127.0.0.1:8091/api/auth/login -H 'Content-Type: application/json' \
  -d '{"email":"dueno@novalab.mx","password":"novalab"}' | head -c 120
# túnel público (URL vigente en url.txt del hub)
URL=$(curl -s https://hibiinova.github.io/novalab/url.txt)
curl -s -o /dev/null -w "%{http_code}\n" "$URL/"              # 200
curl -s -o /dev/null -w "%{http_code}\n" "$URL/finanzas/"     # 200
curl -s -o /dev/null -w "%{http_code}\n" "$URL/seguimiento/"  # 200
# portal
curl -s https://hibiinova.github.io/novalab/ | grep -o 'lnk-\(prod\|fin\|seg\)'  # 3 accesos
# servicios
systemctl is-active novalab-backend novalab-tunnel nginx novalab-deploy.timer
```

En la app Producción (web): login `dueno@novalab.mx` → debe ver **3 impresoras demo, cola y pedidos NL-1001…** (org seed). Registro un dueño nuevo + organización → listas **vacías** (multi-tenant, org nueva).

> **Gap conocido**: Finanzas llama `/api/finance/*` pero el backend aún no expone ese router (solo `app/services/finance.py`); login funciona pero los datos de financias darán 404 hasta implementarlo.

## 8. Multi-tenant (0005) — qué esperar

- Migración `0005_org_scoping` agrega `organization_id` a las tablas operativas, unique compuesto `(organization_id, folio)` y re-key de `queue_version:{org_id}`.
- En BD **existente**, el backfill asigna todo lo previo a la org más antigua (la del dueño demo). **Orgs nuevas arrancan vacías.**
- Si la BD se crea desde cero con `NOVALAB_SEED_DEMO=true`, el seed crea la org demo `ORG-NOVA-101` con usuarios, impresoras, cola y pedidos.

## 9. Troubleshooting

| Síntoma | Acción |
|---|---|
| `novalab-backend` falla al arrancar | `journalctl -u novalab-backend -n 50`; revisa `backend.env` (¿falta `NOVALAB_DB_URL`?) |
| 403 `membership_not_active` en login demo | La BD no pasó por 0005 o el seed no corrió; `alembic upgrade head` + revisa `NOVALAB_SEED_DEMO` |
| Front carga pero `/api` da 404/502 | nginx no proxy-ea: `nginx -t`, revisa `sites-enabled/novalab`, `systemctl reload nginx` |
| Auto-deploy no jala cambios | `journalctl -u novalab-deploy.service`; verifica deploy key (`ssh -i … git@github.com`) y que el timer esté `active` |
| Errores de encoding en auto-deploy (`Backend \303\272nico`) | Usa `git -c core.quotepath=false diff --name-only` (ya incluido en `auto-deploy.sh`) |
| Túnel caído / URL cambió | `systemctl restart novalab-tunnel`; `sync-hub-url.sh` (ExecStartPost) renueva `url.txt` solo — revisa `journalctl -u novalab-tunnel` y `~/.novalab-hub-token` |
| Finanzas carga pero datos vacíos/404 | Gap: aún no existe router `/api/finance/*` en el backend (solo `app/services/finance.py`) |
| `/finanzas` o `/seguimiento` dan 404 | Falta rsync del build o location de nginx: verifica `/var/www/novalab-{finanzas,seguimiento}/` y `nginx -t` |
| OctoPrint sin conexión (poller) | Ver `setup-raspberry-pi-ender3.md`; el poller consulta `127.0.0.1:5000` |
