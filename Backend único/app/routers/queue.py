"""Cola: `GET /api/queue`, reorder, suggest, accept (BE-11..BE-14)."""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.events import hub
from app.schemas import (
    Queue,
    QueueAcceptRequest,
    QueueReorderRequest,
    QueueSuggestion,
)
from app.services import queue as queue_service

router = APIRouter(prefix="/api/queue", tags=["queue"])


@router.get("", operation_id="getQueue", response_model=Queue,
            dependencies=[Depends(get_current_user)])
def get_queue(db: Session = Depends(get_db)):
    return queue_service.build_queue(db)


@router.post("/reorder", operation_id="reorderQueue",
             dependencies=[Depends(get_current_user)])
async def reorder(body: QueueReorderRequest, db: Session = Depends(get_db)):
    """BE-12/optimistic concurrency: 409 si `version` no coincide."""
    if not queue_service.check_version(db, body.version):
        raise HTTPException(
            409,
            {"code": "version_conflict",
             "message": "La cola cambió. Recarga e intenta de nuevo.",
             "current_version": queue_service.get_version(db)},
        )
    version = queue_service.apply_entries(
        db, [e.model_dump() for e in body.items]
    )
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return {"version": version}


@router.post("/suggest", operation_id="suggestQueueAssignment",
             response_model=QueueSuggestion,
             dependencies=[Depends(get_current_user)])
def suggest(db: Session = Depends(get_db)):
    return queue_service.suggest(db)


@router.post("/accept", operation_id="acceptQueueAssignment",
             dependencies=[Depends(get_current_user)])
async def accept(body: QueueAcceptRequest, db: Session = Depends(get_db)):
    if not queue_service.check_version(db, body.version):
        raise HTTPException(
            409,
            {"code": "version_conflict",
             "message": "La cola cambió. Recarga e intenta de nuevo.",
             "current_version": queue_service.get_version(db)},
        )
    version = queue_service.apply_entries(
        db, [e.model_dump() for e in body.assignments]
    )
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return {"version": version}
