"""Punto de entrada FastAPI. Arranque: uvicorn app.main:app --port 8081."""

from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy import select

from app.config import settings
from app.db import Base, get_session_factory, get_engine, init_db
from app.routers import auth, catalog, orders, print_jobs, printers, public, queue, ws
from app.seed import seed_demo


@asynccontextmanager
async def lifespan(app: FastAPI):
    init_db(settings.db_url)
    # Crea las tablas si faltan (idempotente). Alembic queda para migraciones
    # de producción; en dev/tests esto evita el paso manual inicial.
    Base.metadata.create_all(get_engine())
    if settings.seed_demo:
        session = get_session_factory()()
        try:
            seed_demo(session)
        finally:
            session.close()
    yield


app = FastAPI(
    title="NOVALAB API",
    version="0.1.0",
    description="Backend único (BE-01..BE-21) para el ecosistema NOVALAB.",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    # Flutter web usa puertos aleatorios en dev; cualquier localhost pasa.
    allow_origin_regex=r"http://(localhost|127\.0\.0\.1)(:\d+)?",
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException):
    """Respuesta uniforme `{code, message}` (schema Error del contrato)."""
    detail = exc.detail
    if isinstance(detail, dict) and "code" in detail:
        return JSONResponse(status_code=exc.status_code, content=detail)
    return JSONResponse(
        status_code=exc.status_code,
        content={"code": "error", "message": str(detail)},
    )


@app.exception_handler(Exception)
async def api_error_handler(request: Request, exc: Exception):
    return JSONResponse(
        status_code=500,
        content={"code": "internal_error",
                 "message": "Error interno del servidor."},
    )


@app.get("/health", tags=["health"], operation_id="health")
def health():
    return {"status": "ok", "version": "0.1.0"}


# Routers
app.include_router(auth.router)
app.include_router(public.router)
app.include_router(printers.router)
app.include_router(queue.router)
app.include_router(print_jobs.router)
app.include_router(orders.router)
app.include_router(catalog.router)
app.include_router(ws.router)
