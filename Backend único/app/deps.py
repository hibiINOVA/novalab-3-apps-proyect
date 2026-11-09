"""Dependencias FastAPI: JWT, roles (BE-17) y rate limit (BE-19)."""

from fastapi import Depends, HTTPException, Request
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.models import Organization, User
from app.ratelimit import (
    login_limiter,
    lookup_limiter,
    public_limiter,
    register_limiter,
)
from app.security import decode_token

_bearer = HTTPBearer(auto_error=False)


def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(_bearer),
    db: Session = Depends(get_db),
) -> User:
    if credentials is None:
        raise HTTPException(
            status_code=401,
            detail={"code": "unauthorized", "message": "Token requerido."},
        )
    payload = decode_token(credentials.credentials, "access")
    if payload is None:
        raise HTTPException(
            status_code=401,
            detail={"code": "unauthorized", "message": "Token inválido o expirado."},
        )
    user = db.get(User, int(payload["sub"]))
    if user is None:
        raise HTTPException(
            status_code=401,
            detail={"code": "unauthorized", "message": "Usuario no existe."},
        )
    return user


def require_owner(user: User = Depends(get_current_user)) -> User:
    """BE-17: solo `owner` (finanzas, usuarios, ajustes)."""
    if user.role != "owner":
        raise HTTPException(
            status_code=403,
            detail={"code": "forbidden", "message": "Requiere rol owner."},
        )
    return user


def get_current_org(
    user: User = Depends(get_current_user), db: Session = Depends(get_db)
) -> Organization:
    """Org activa del usuario multi-tenant.

    Los recursos operativos se consultan siempre con la org resuelta
    aquí (desde el JWT → user.organization_id); exige membresía `active`.
    """
    if user.organization_id is None or user.membership_status != "active":
        raise HTTPException(
            status_code=403,
            detail={
                "code": "membership_not_active",
                "message": "No perteneces a una organización activa.",
            },
        )
    org = db.get(Organization, user.organization_id)
    if org is None:
        raise HTTPException(
            status_code=403,
            detail={
                "code": "membership_not_active",
                "message": "La organización ya no existe.",
            },
        )
    return org


def _client_ip(request: Request) -> str:
    return request.client.host if request.client else "unknown"


def limit_login(request: Request, email: str = "") -> None:
    key = f"{_client_ip(request)}|{email}"
    if not login_limiter.check(key):
        raise HTTPException(
            status_code=429,
            detail={"code": "rate_limited",
                    "message": "Demasiados intentos. Intenta más tarde."},
        )


def limit_register(request: Request) -> None:
    if not register_limiter.check(_client_ip(request)):
        raise HTTPException(
            status_code=429,
            detail={"code": "rate_limited",
                    "message": "Demasiados intentos. Intenta más tarde."},
        )


def limit_lookup(request: Request) -> None:
    if not lookup_limiter.check(_client_ip(request)):
        raise HTTPException(
            status_code=429,
            detail={"code": "rate_limited",
                    "message": "Demasiados intentos. Intenta más tarde."},
        )


def limit_public(request: Request) -> None:
    if not public_limiter.check(_client_ip(request)):
        raise HTTPException(
            status_code=429,
            detail={"code": "rate_limited",
                    "message": "Demasiadas peticiones."},
        )
