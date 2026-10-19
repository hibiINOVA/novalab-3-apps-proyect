"""Snapshot de cámaras (BE-07..BE-09). El backend solo sirve el snapshot
cacheado; jamás expone la IP de la impresora al cliente.

Soporta multi-cámara (BE-07): cada impresora tiene una lista de URLs de
snapshot (mjpg-streamer `?action=snapshot`, camera-streamer, etc.). El
poller guarda el último JPEG en `data/snapshots/{printer_id}/{index}.jpg`
mientras hay un job activo; el endpoint sirve desde ahí con cache TTL.
"""

import json
import time
from io import BytesIO
from pathlib import Path

import httpx
from sqlalchemy.orm import Session

from app.config import settings
from app.models import OrderItem, PrintJob, Printer
from app.storage import storage_dir

# 1x1 PNG (placeholder cuando no hay snapshot real).
TINY_PNG = bytes.fromhex(
    "89504e470d0a1a0a0000000d49484452000000010000000108060000001f15c489"
    "0000000d4944415478da63f8cf4000000301010018dd8db10000000049454e44ae426082"
)

_SNAPSHOT_TIMEOUT = 3.0
# Cache en memoria: key "printer_id:index" → (monotonic_ts, bytes).
_JPEG_CACHE: dict[str, tuple[float, bytes]] = {}


def camera_urls(p: Printer) -> list[str]:
    """Lista de URLs de snapshot de la impresora (JSON en `camera_urls`)."""
    if p.camera_urls:
        try:
            urls = json.loads(p.camera_urls)
            if isinstance(urls, list):
                return [str(u) for u in urls]
        except ValueError:
            pass
    return [p.snapshot_url] if p.snapshot_url else []


def snapshots_dir() -> Path:
    return storage_dir() / "snapshots"


def fetch_snapshot(printer: Printer, index: int = 0) -> bytes | None:
    """BE-07: descarga el snapshot de la cámara `index` (jpeg/png o None)."""
    urls = camera_urls(printer)
    if index >= len(urls):
        return None
    url = urls[index]
    if url.startswith("/"):
        # Snapshot en disco (demo/seed).
        path = Path(url)
        return path.read_bytes() if path.is_file() else None
    try:
        resp = httpx.get(url, timeout=_SNAPSHOT_TIMEOUT,
                         follow_redirects=True)
    except httpx.HTTPError:
        return None
    if resp.status_code != 200 or not resp.content:
        return None
    # Validar que sea imagen (magic bytes).
    if resp.content[:2] not in (b"\xff\xd8", b"\x89P"):
        return None
    return resp.content


def _try_pillow_jpeg(label: str) -> bytes | None:
    try:
        from PIL import Image, ImageDraw
    except ImportError:
        return None
    img = Image.new("RGB", (320, 240), (40, 44, 52))
    draw = ImageDraw.Draw(img)
    draw.text((20, 110), f"NOVALAB {label}", fill=(0, 255, 135))

    buf = BytesIO()
    img.save(buf, format="JPEG", quality=70)
    return buf.getvalue()


def _read_disk_snapshot(printer_id: int, index: int) -> bytes | None:
    path = snapshots_dir() / str(printer_id) / f"{index}.jpg"
    if path.is_file():
        return path.read_bytes()
    return None


def get_snapshot(db: Session, printer_id: int, index: int = 0) -> bytes | None:
    """Devuelve JPEG/PNG cacheado del snapshot o None si no hay."""
    printer = db.get(Printer, printer_id)
    if printer is None:
        return None
    key = f"{printer_id}:{index}"
    cached = _JPEG_CACHE.get(key)
    now = time.monotonic()
    if cached and now - cached[0] < settings.snapshot_interval:
        return cached[1]

    data = _read_disk_snapshot(printer_id, index)
    if data is None and index == 0:
        # Fallback: intenta fetch en vivo (solo cámara principal).
        data = fetch_snapshot(printer, index)
    if data is None and printer.state != "offline":
        data = _try_pillow_jpeg(printer.name) or TINY_PNG
    if data is None:
        return None
    _JPEG_CACHE[key] = (now, data)
    return data


def get_public_snapshot(db: Session, order_id: int) -> bytes | None:
    """Snapshot público: solo si el pedido tiene un job activo (C-06)."""
    job = (
        db.query(PrintJob)
        .join(OrderItem, PrintJob.item_id == OrderItem.id)
        .filter(OrderItem.order_id == order_id, PrintJob.state == "printing")
        .first()
    )
    if job is None:
        return None
    return get_snapshot(db, job.printer_id)


def clear_cache() -> None:
    _JPEG_CACHE.clear()
