"""Hub de eventos WebSocket `/ws` (BE: tiempo real, doc §3.9).

Broadcast en memoria: los routers publican `StatusEvent` y el hub los envía a
todos los clientes conectados. Autenticación por `?token=` (JWT access).
"""

import asyncio
import json
from datetime import UTC, datetime

from fastapi import WebSocket


class EventHub:
    def __init__(self) -> None:
        self._clients: set[WebSocket] = set()

    async def connect(self, ws: WebSocket) -> None:
        await ws.accept()
        self._clients.add(ws)

    def disconnect(self, ws: WebSocket) -> None:
        self._clients.discard(ws)

    async def broadcast(self, type_: str, entity: str, entity_id: int | None = None,
                        payload: dict | None = None) -> None:
        if not self._clients:
            return
        event = {
            "type": type_,
            "entity": entity,
            "entity_id": entity_id,
            "payload": payload or {},
            "occurred_at": datetime.now(UTC).isoformat(),
        }
        message = json.dumps(event, ensure_ascii=False)
        dead: list[WebSocket] = []
        for client in list(self._clients):
            try:
                await client.send_text(message)
            except Exception:
                dead.append(client)
        for client in dead:
            self._clients.discard(client)

    def broadcast_sync(self, type_: str, entity: str, entity_id: int | None = None,
                       payload: dict | None = None) -> None:
        """Versión para routers síncronos: encola en el loop principal."""
        if not self._clients:
            return
        loop = asyncio.get_event_loop()
        if loop.is_running():
            asyncio.ensure_future(
                self.broadcast(type_, entity, entity_id, payload), loop=loop
            )


hub = EventHub()
