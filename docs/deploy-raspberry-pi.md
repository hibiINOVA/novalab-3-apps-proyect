# Deploy en Raspberry Pi — desde cero

Procedimiento completo para levantar NOVALAB en una Pi limpia: backend + front + túnel público + auto-deploy. Cita `BE-01`…`BE-26` (integración impresora en `setup-raspberry-pi-ender3.md`).

**Topology final**

| Componente | Puerto | Ruta/servicio |
|---|---|---|
| Backend (uvicorn) | `8090` (solo localhost) | `/opt/novalab/backend`, svc `novalab-backend` |
| nginx (front + proxy) | `8091` (0.0.0.0) | root `/var/www/novalab`, `/api/*` y `/ws` → `127.0.0.1:8090` |
| Cloudflared tunnel | — | `novalab-tunnel.service` → `http://127.0.0.1:8091` (URL efímera) |
| Hub público | 443 | GitHub Pages `https://hibiinova.github.io/novalab/` lee `url.txt` y redirige al túnel |
| Auto-deploy | cada 120 s | `novalab-deploy.timer` → `/opt/novalab/auto-deploy.sh` |
| OctoPrint (opcional) | `5000` | ver `docs/setup-raspberry-pi-ender3.md` |

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
/var/www/novalab/      # front Flutter (rsync desde app-repo/deploy/web/)
```

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
.venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8090 &
curl -s http://127.0.0.1:8090/health   # {"ok": true}
```

### Servicio systemd — `/etc/systemd/system/novalab-backend.service`

(Disponible en `deploy/pi/novalab-backend.service`.)

```bash
sudo cp deploy/pi/novalab-backend.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-backend
systemctl is-active novalab-backend   # active
```

## 4. Front + nginx

```bash
# el build de producción vive en el repo: deploy/web/
sudo rsync -a --delete /opt/novalab/app-repo/deploy/web/ /var/www/novalab/
sudo cp deploy/pi/nginx-novalab.conf /etc/nginx/sites-available/novalab
sudo ln -sf /etc/nginx/sites-available/novalab /etc/nginx/sites-enabled/novalab
sudo nginx -t && sudo systemctl reload nginx
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/          # 200
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/api/health # 200 (proxy)
```

Rebuild del front cuando cambie `Producción/` (desde tu máquina local):

```bash
cd Producción && flutter build web --release
rsync -a --delete build/web/ ../deploy/web/
git add ../deploy/web && git commit -m "chore(web): rebuild front" && git push
# el auto-deploy de la Pi lo sincroniza solo (≤2 min)
```

## 5. Túnel público (Cloudflared)

```bash
# instalar cloudflared (binario oficial)
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt update && sudo apt install -y cloudflared
```

Servicio — `deploy/pi/novalab-tunnel.service`:

```bash
sudo cp deploy/pi/novalab-tunnel.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-tunnel
sleep 12
journalctl -u novalab-tunnel --no-pager | grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' | head -1
```

### Publicar la URL en el hub (Pages)

El hub `https://hibiinova.github.io/novalab/` lee `url.txt` del repo `hibiINOVA/novalab` (repo distinto) y redirige. Actualízalo con la URL nueva del túnel:

```bash
# desde tu máquina local
URL=$(journalctl -u novalab-tunnel --no-pager | grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' | tail -1)
# actualiza url.txt en el repo hibiINOVA/novalab (API de GitHub o UI)
```

> La URL del túnel **efímera cambia en cada reinicio** de `cloudflared`. El auto-deploy no la renueva; si se cae el túnel, repasa este paso.

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
curl -s http://127.0.0.1:8090/health                          # {"ok": true}
# front + proxy
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8091/
# login demo vía proxy
curl -s http://127.0.0.1:8091/api/auth/login -H 'Content-Type: application/json' \
  -d '{"email":"dueno@novalab.mx","password":"novalab"}' | head -c 120
# túnel
curl -s -o /dev/null -w "%{http_code}\n" <URL_TUNNEL>/
# servicios
systemctl is-active novalab-backend novalab-tunnel nginx novalab-deploy.timer
```

En la app Producción (web): login `dueno@novalab.mx` → debe ver **3 impresoras demo, cola y pedidos NL-1001…** (org seed). Registro un dueño nuevo + organización → listas **vacías** (multi-tenant, org nueva).

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
| Túnel caído / URL cambió | `systemctl restart novalab-tunnel`, copia la URL nueva al `url.txt` del hub Pages |
| OctoPrint sin conexión (poller) | Ver `setup-raspberry-pi-ender3.md`; el poller consulta `127.0.0.1:5000` |
