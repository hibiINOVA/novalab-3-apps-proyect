"""WebSocket `/ws` (BE: tiempo real). Auth por `?token=` (JWT access).

El backend envía un evento `session.ready` de bienvenida para que el cliente
sepa que la conexión está activa (el cliente Dart solo marca `connected`
tras recibir el primer mensaje)."""

import json

from fastapi import APIRouter, Query, WebSocket, WebSocketDisconnect
from sqlalchemy.orm import Session

from app.db import get_session_factory
from app.events import hub
from app.security import decode_token

router = APIRouter()


def _open_db() -> Session:
    return get_session_factory()()


@router.websocket("/ws")
async def ws_endpoint(websocket: WebSocket, token: str = Query(default="")):
    payload = decode_token(token, "access")
    if payload is None:
        await websocket.close(code=4401, reason="unauthorized")
        return
    await hub.connect(websocket)
    # Bienvenida: el cliente Dart necesita un primer mensaje para confirmar.
    await websocket.send_text(json.dumps({
        "type": "session.ready",
        "entity": "session",
        "payload": {"user_id": int(payload["sub"])},
    }, ensure_ascii=False))
    try:
        while True:
            # Mantenemos la conexión; el cliente puede enviar ping.
            msg = await websocket.receive_text()
            if msg == "ping":
                await websocket.send_text(json.dumps({"type": "pong"}))
    except WebSocketDisconnect:
        pass
    finally:
        hub.disconnect(websocket)
