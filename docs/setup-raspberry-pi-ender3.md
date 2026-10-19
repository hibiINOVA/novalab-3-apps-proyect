# Guía: Ender 3 V3 SE + OctoPrint + 2 cámaras USB en Raspberry Pi 4

Integración NOVALAB (Fase 3, `BE-01`…`BE-08`, `BE-20`, `BE-26`). Asume:

- Una **Raspberry Pi 4** (2 GB o más recomendado) conectada a la red local (LAN, no Wi-Fi para producción).
- La **Ender 3 V3 SE** vía USB (la tarjeta controladora GRBL/STM32 de la V3 SE es compatible con OctoPrint vía cable USB-C).
- **2 cámaras USB** para la misma impresora (2 ángulos; índice 0 = principal).
- El backend NOVALAB corre **en la misma Pi** que OctoPrint.

> **Carga eléctrica (doc §11):** la Pi no debe alimentar la impresora; la impresora usa su propia fuente. La Pi se alimenta con fuente oficial USB-C de 5 V/3 A. No uses la impresora para alimentar la Pi.

## 1. Sistema base

1. Flashea **Raspberry Pi OS Lite (64-bit)** con Raspberry Pi Imager (usuario, Wi-Fi/LAN y SSH habilitados).
2. Arranca, entra por SSH y actualiza:

```bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y git cmake libjpeg62-turbo-dev libv4l-dev \
  python3-venv python3-pip ffmpeg
sudo reboot
```

3. Verifica que las cámaras se vean (USB):

```bash
lsusb                    # Debe listar las 2 cámaras
v4l2-ctl --list-devices  # /dev/video0 y /dev/video1
```

## 2. OctoPrint

Sigue la guía oficial de OctoPrint; resumen:

```bash
sudo usermod -aG dialout,gpio,video $USER
cd ~ && curl -L https://octoprint.org/install.sh | bash
```

- Arranca en `http://<IP-DE-LA-PI>:5000` y completa el asistente (crear usuario).
- **Printer:** marca "Detected printer" (la V3 SE aparece como puerto serie USB). Si no aparece, prueba otro cable USB (algunos son solo de carga).
- **API key:** en OctoPrint ve a *Settings → API → Global API key* y copia la llave. La necesitarás para el backend.

Prueba de conexión desde la Pi:

```bash
curl -s -H "X-Api-Key: TU_API_KEY" http://127.0.0.1:5000/api/job
# Debe devolver JSON con "state" (Operacional o Idle, no un 401/403)
```

## 3. Cámaras USB (2 ángulos)

La forma más limpia con 2 cámaras es **octoprint-camerastreamer** (sirve snapshot + stream por USB sin mJPEG costoso):

```bash
cd ~ && git clone https://github.com/jefflenovo/octoprint-camerastreamer.git
# (o el fork oficial del plugin MultiCam / webcam.conf según tu versión;
#  la idea es 2 servicios, uno por /dev/videoX)
```

Configura **2 servicios** (uno por cámara) escuchando en puertos distintos:

| Servicio  | Dispositivo   | Puerto | Snapshot URL |
|-----------|---------------|--------|--------------|
| cam1 (0)  | `/dev/video0` | 8080   | `http://127.0.0.1:8080/?action=snapshot` |
| cam2 (1)  | `/dev/video1` | 8081   | `http://127.0.0.1:8081/?action=snapshot` |

Verifica que los snapshots respondan (deben ser JPEG):

```bash
curl -s -o /tmp/c1.jpg -w "%{http_code} %{content_type}\n" \
  "http://127.0.0.1:8080/?action=snapshot"
file /tmp/c1.jpg   # JPEG image data
```

## 4. Backend NOVALAB en la Pi

```bash
sudo mkdir -p /opt/novalab && sudo chown $USER /opt/novalab
git clone <REPO> /opt/novalab/repo
cd /opt/novalab/repo/"Backend único"
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

Variables de entorno (`/opt/novalab/backend.env`, permisos 600):

```ini
NOVALAB_SECRET_KEY=<cadena larga y aleatoria; genera con: python -c "import secrets;print(secrets.token_urlsafe(48))">
NOVALAB_JWT_SECRET=<otra cadena aleatoria distinta>
NOVALAB_DB_URL=sqlite:////opt/novalab/data/novalab.db
NOVALAB_SEED_DEMO=true
NOVALAB_POLLER_ENABLED=true
```

> `NOVALAB_SECRET_KEY` cifra las API keys de impresora en BD (BE-20). Si la pierdes, las impresoras quedan sin API key y hay que volver a guardarlas.

Aplica migraciones y prueba:

```bash
cd /opt/novalab/repo/"Backend único"
source .venv/bin/activate
alembic upgrade head
uvicorn app.main:app --host 127.0.0.1 --port 8081
# En otra terminal:
curl -s http://127.0.0.1:8081/api/health   # 200
```

### Servicio systemd

`/etc/systemd/system/novalab-backend.service`:

```ini
[Unit]
Description=NOVALAB Backend
After=network.target

[Service]
User=pi
WorkingDirectory=/opt/novalab/repo/Backend único
EnvironmentFile=/opt/novalab/backend.env
ExecStart=/opt/novalab/repo/Backend único/.venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8081
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now novalab-backend
sudo systemctl status novalab-backend
```

El poller (BE-02/03/04/26) arranca con el backend y consulta OctoPrint en `http://127.0.0.1:5000`; descarga snapshots a `/opt/novalab/data/snapshots/` y los sirve vía la API.

## 5. Alta en la app NOVALAB (Producción)

1. Abre la app Producción y entra como dueño (`dueno@novalab.mx` / `novalab` en seed demo).
2. Impresores → **Nueva impresora**:

| Campo | Valor |
|-------|-------|
| Nombre | `Ender 3 V3 SE` |
| Modelo | `Ender 3 V3 SE` |
| URL de OctoPrint | `http://127.0.0.1:5000` |
| API key | la copiada en el paso 2 |
| Tiene cámara | sí |
| URL cámaras (1 por línea) | `http://127.0.0.1:8080/?action=snapshot`<br>`http://127.0.0.1:8081/?action=snapshot` |

3. Pulsa **Probar conexión**: debe responder "Conexión exitosa con OctoPrint" (BE-01).
4. Guarda. En ~10 s el poller la marca en línea con temperatura real (BE-02).
5. Sube un G-code desde un pedido: el backend lo envía a OctoPrint e **inicia la impresión solo si el operador lo confirma** (BE-05, P-05 — nunca auto-arranque).

## 6. Seguridad (BE-08, BE-21, BE-22)

- La Pi y el backend viven en la **red privada** (LAN/VPN). No expongas 5000/8080/8081 a internet.
- Si la app corre fuera de la Pi, el backend expone los snapshots **provenientes del backend**, nunca el stream ni la IP de la impresora.
- El cliente público de tracking solo ve la cámara principal (índice 0) vía su `tracking_token`; nunca ve costos, otros clientes ni la red interna.
- Cambia la contraseña del usuario de OctoPrint y usa una API key dedicada (no la global por defecto si puedes crear una por aplicación).

## 7. Solución de problemas

| Síntoma | Causa probable | Acción |
|---------|----------------|--------|
| Impresora "offline" (BE-26) | OctoPrint caído o URL/API key mal | `systemctl status octoprint`; rehaz *Probar conexión* |
| Sin snapshot (404) | Servicio de cámara caído o URL mal | `curl` a cada `?action=snapshot`; revisa puertos 8080/8081 |
| Impresión no arranca | G-code mal formateado o OctoPrint rechaza el job | Revisa logs del backend y OctoPrint; reintenta el upload |
| API key inválida tras mover BD | `NOVALAB_SECRET_KEY` cambió | Vuelve a guardar la API key en la app |
| Temperaturas en 0 | OctoPrint conectado a puerto equivocado | Vuelve a seleccionar el puerto serie correcto en OctoPrint |

Logs útiles:

```bash
journalctl -u novalab-backend -f
journalctl -u octoprint -f   # si usas el servicio oficial
```

## Fuera de alcance (v1)

Klipper/Moonraker, timelapse, descuento real de gramos del spool, túnel público (Caddy/Cloudflare). La app debe estar en red privada (LAN/VPN/Cloudflare Access).
