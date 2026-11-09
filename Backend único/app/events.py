"""Hub de eventos WebSocket `/ws` (BE: tiempo real, doc §3.9).

Broadcast en memoria por organización (multi-tenant): los routers
publican `StatusEvent` con `org_id` y el hub solo lo envía a los
clientes conectados de esa organización. Autenticación por `?token=`
(JWT access); la org se resuelve al conectar.
"""

import asyncio
import json
from datetime import UTC, datetime

from fastapi import WebSocket


class EventHub:
    def __init__(self) -> None:
        # ws → organization_id (None = sin org, no recibe broadcasts).
        self._clients: dict[WebSocket, int | None] = {}

    async def connect(self, ws: WebSocket, org_id: int | None) -> None:
        await ws.accept()
        self._clients[ws] = org_id

    def disconnect(self, ws: WebSocket) -> None:
        self._clients.pop(ws, None)

    async def broadcast(self, type_: str, entity: str,
                        entity_id: int | None = None,
                        payload: dict | None = None,
                        org_id: int | None = None) -> None:
        targets = [
            ws for ws, client_org in self._clients.items()
            if org_id is None or client_org == org_id
        ]
        if not targets:
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
        for client in targets:
            try:
                await client.send_text(message)
            except Exception:
                dead.append(client)
        for client in dead:
            self._clients.pop(client, None)

    def broadcast_sync(self, type_: str, entity: str,
                       entity_id: int | None = None,
                       payload: dict | None = None,
                       org_id: int | None = None) -> None:
        """Versión para routers síncronos: encola en el loop principal."""
        if not self._clients:
            return
        loop = asyncio.get_event_loop()
        if loop.is_running():
            asyncio.ensure_future(
                self.broadcast(type_, entity, entity_id, payload,
                               org_id=org_id),
                loop=loop,
            )


hub = EventHub()
