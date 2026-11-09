"""Cola: `GET /api/queue`, reorder, suggest, accept (BE-11..BE-14).

Multi-tenant: la cola, el versionado y las sugerencias son por
organización."""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_org
from app.events import hub
from app.models import Organization
from app.schemas import (
    Queue,
    QueueAcceptRequest,
    QueueReorderRequest,
    QueueSuggestion,
)
from app.services import queue as queue_service

router = APIRouter(prefix="/api/queue", tags=["queue"])


@router.get("", operation_id="getQueue", response_model=Queue)
def get_queue(org: Organization = Depends(get_current_org),
              db: Session = Depends(get_db)):
    return queue_service.build_queue(db, org.id)


@router.patch("/reorder", operation_id="reorderQueue", response_model=Queue)
async def reorder(body: QueueReorderRequest,
                  org: Organization = Depends(get_current_org),
                  db: Session = Depends(get_db)):
    """BE-12/optimistic concurrency: 409 si `version` no coincide."""
    if not queue_service.check_version(db, org.id, body.version):
        raise HTTPException(
            409,
            {"code": "version_conflict",
             "message": "La cola cambió. Recarga e intenta de nuevo.",
             "current_version": queue_service.get_version(db, org.id)},
        )
    version = queue_service.apply_entries(
        db, org.id, [e.model_dump() for e in body.items]
    )
    await hub.broadcast("queue.updated", "queue", payload={"version": version},
                        org_id=org.id)
    return queue_service.build_queue(db, org.id)


@router.post("/suggest", operation_id="suggestQueueAssignment",
             response_model=QueueSuggestion)
def suggest(org: Organization = Depends(get_current_org),
            db: Session = Depends(get_db)):
    return queue_service.suggest(db, org.id)


@router.post("/accept", operation_id="acceptQueueAssignment",
             response_model=Queue)
async def accept(body: QueueAcceptRequest,
                 org: Organization = Depends(get_current_org),
                 db: Session = Depends(get_db)):
    if not queue_service.check_version(db, org.id, body.version):
        raise HTTPException(
            409,
            {"code": "version_conflict",
             "message": "La cola cambió. Recarga e intenta de nuevo.",
             "current_version": queue_service.get_version(db, org.id)},
        )
    version = queue_service.apply_entries(
        db, org.id, [e.model_dump() for e in body.assignments]
    )
    await hub.broadcast("queue.updated", "queue", payload={"version": version},
                        org_id=org.id)
    return queue_service.build_queue(db, org.id)
