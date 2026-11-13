# Plan: levantar NOVALAB como servidor en Raspberry Pi y después eliminar TODO sin dejar rastro

**Objetivo:** levantar el backend de NOVALAB en la Pi como servidor real (expuesto por la IP local `192.168.1.84` para que sea consumido desde fuera de la red local), y luego borrar por completo: procesos, venv, base de datos, migraciones, builds, nginx, y cualquier rastro, quedando el sistema limpio.

> Requisito del usuario: crear el plan primero, guardarlo como `.md`, y solo después ejecutar. Nada queda después.

---

## 1. Estado actual verificado (antes de tocar nada)

| Elemento | Estado |
|---|---|
| IP de la Pi | `192.168.1.84` (y IPv6) |
| Puerto 8080 | `ustreamer` (cámara HP) solo en `127.0.0.1` — **NO es novalab** |
| Puerto 8081 | `ustreamer` (cámara genérica) solo en `127.0.0.1` — **NO es novalab** |
| Puerto 8090 | `youtube_live.py` (pid 1140) — **NO es novalab** |
| Backend novalab | **NO está corriendo** |
| `.venv` en `Backend único/` | **NO existe** |
| Servicios systemd de novalab | **Ninguno** instalado |
| nginx | **Instalado** (`nginx/1.26.3`) |
| cloudflared | **NO instalado** |
| ufw / firewall | **No disponible** |
| `/opt/novalab` | No existe |
| `/data` | No existe |
| `deploy/pi/` | Referencias: systemd units, nginx conf (puerto 8091 → 127.0.0.1:8090), auto-deploy.sh |

> Nota: los puertos 8080/8081 están ocupados por cámaras, no por novalab. El backend de novalab usará otro puerto (por defecto 8081 según `app/main.py`, pero 8081 está ocupado por ustreamer). Se usará **8090** para el backend si está libre, o se define uno libre. Como 8090 lo usa `youtube_live.py`, se elegirá un puerto libre (p. ej. **8082**) para no colisionar.

---

## 2. Fase A — Levantamiento como servidor (consumible desde fuera de la red local)

Todo desde la raíz del repo `/home/hibi/novalab-3-apps-proyect`.

### A.1 Backend único (expuesto en 0.0.0.0 para acceso externo)

```bash
cd "Backend único"

# 1. Crear venv (no existe)
python -m venv .venv
source .venv/bin/activate

# 2. Instalar dependencias (incluye pytest)
pip install -e ".[dev]"

# 3. Levantar expuesto en todas las interfaces (0.0.0.0) para que sea consumido desde fuera
#    Elegir un puerto libre (8082 si 8080/8081/8090 están ocupados por cámaras/youtube)
uvicorn app.main:app --host 0.0.0.0 --port 8082
```

- El backend auto-crea tablas y hace seed demo (`seed_demo`).
- Verificar desde la Pi: `curl http://127.0.0.1:8082/health` y `http://127.0.0.1:8082/docs`.
- Verificar desde otra máquina de la red: `curl http://192.168.1.84:8082/health`.
- Demo creds: `dueno@novalab.mx` / `operador@novalab.mx`, password `novalab`.

### A.2 (Opcional) nginx como reverse proxy público

Si se quiere exponer por el puerto 80 (estándar web) y que lo consuman clientes externos:

```bash
sudo nginx -t
sudo systemctl start nginx
sudo systemctl enable nginx
```

Crear `/etc/nginx/sites-available/novalab` (o añadir al `nginx.conf`) con `listen 80` y `proxy_pass http://127.0.0.1:8082`, incluyendo `/ws` para WebSocket. Luego `sudo nginx -s reload`.

Sin cloudflared, el acceso externo a `192.168.1.84:8082` depende del router de la red local (no hay túnel público configurado).

### A.3 Pruebas rápidas

- Backend: `cd "Backend único" && source .venv/bin/activate && python -m pytest tests/ -q` (60 tests).
- Flutter (Producción) contra el backend real: `cd Producción && flutter run -d chrome --dart-define=USE_MOCKS=false --dart-define=API_BASE_URL=http://192.168.1.84:8082`.

---

## 3. Fase B — Eliminación total (dejar sin nada)

Este es el núcleo del pedido: **no dejar nada de nada** — procesos, venv, DB, nginx, rastreos.

### B.1 Detener y matar procesos de novalab

```bash
# Buscar procesos de novalab/uvicorn
ps aux | grep -iE 'novalab|uvicorn|app.main' | grep -v grep

# Matar los pids encontrados
kill <pid1> <pid2> ...
kill -9 <pid1> ...   # si resisten

# Verificar que el puerto queda libre
ss -tlnp | grep ':8082'   # debe devolver vacío
```

> No tocar los puertos 8080/8081 (cámaras ustreamer) ni 8090 (youtube_live) si no son de novalab.

### B.2 Eliminar nginx y su configuración de novalab

```bash
sudo systemctl stop nginx 2>/dev/null
sudo systemctl disable nginx 2>/dev/null
sudo rm -f /etc/nginx/sites-enabled/novalab /etc/nginx/sites-available/novalab 2>/dev/null
# si se agregó al nginx.conf, remover el bloque
sudo nginx -t && sudo systemctl reload nginx 2>/dev/null || true
```

### B.3 Eliminar carpetas y artefactos de ejecución

```bash
cd /home/hibi/novalab-3-apps-proyect

# Backend: venv, migraciones generadas, data, db
rm -rf "Backend único/.venv" "Backend único/app/migrations" "Backend único/data" "Backend único"/*.db 2>/dev/null

# Cualquier runtime en /opt/novalab y /data
sudo rm -rf /opt/novalab /data 2>/dev/null

# Builds de Flutter (si se generaron)
rm -rf Producción/build Producción/.dart_tool 2>/dev/null
```

### B.4 Limpiar puertos y verificar

```bash
ss -tlnp | grep -E ':(8082|8090)\b' || echo "NINGUN PUERTO NOVALAB ESCUCHANDO"
```

### B.5 Verificación final de "sin nada"

```bash
echo "--- procesos novalab ---"; ps aux | grep -iE 'novalab|uvicorn|app.main' | grep -v grep || echo "NINGUNO"
echo "--- puertos 8082/8090 ---"; ss -tlnp | grep -E ':(8082|8090)\b' || echo "NINGUN PUERTO"
echo "--- servicios systemd novalab ---"; systemctl list-units --type=service 2>/dev/null | grep -i novalab || echo "NINGUNO"
echo "--- nginx habilitado? ---"; systemctl is-enabled nginx 2>/dev/null || echo "NO"
echo "--- /opt/novalab ---"; ls /opt/novalab 2>/dev/null || echo "NO EXISTE"
echo "--- /data ---"; ls /data 2>/dev/null || echo "NO EXISTE"
echo "--- venv backend ---"; ls "Backend único/.venv" 2>/dev/null || echo "NO EXISTE"
```

---

## 4. Regla de seguridad

- **Nunca** dejar el backend corriendo en segundo plano sin un `kill` explícito al final.
- **Nunca** dejar `.venv`, `data/`, `migrations/`, `*.db` o `build/` generados.
- Si se instaló/configuró nginx para novalab, debe deshacerse y recargarse nginx.

---

## 5. Orden de ejecución (resumen)

1. Revisar este plan (`PLAN_LEVANTAR_Y_ELIMINAR_TOTAL.md`).
2. Fase A: levantar backend expuesto (`uvicorn ... --host 0.0.0.0 --port 8082`), comprobar `/health` desde la Pi y desde otra máquina de la red.
3. Fase B: matar procesos, desconfigurar nginx si se usó, borrar `.venv`, `data/`, `migrations/`, `*.db`, `build/`, `/opt/novalab`, `/data`, liberar puertos.
4. Fase B.5: verificar que no queda **nada**.

---

Cuando estés de acuerdo, dime y procedo con el **levantamiento (Fase A)** como servidor en la Pi.
