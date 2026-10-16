"""Autenticación: `POST /api/auth/login`, `POST /api/auth/refresh`,
`GET /api/auth/me`. Operaciones idénticas a las del contrato."""

from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user, limit_login, limit_register
from app.models import User
from app.schemas import (
    LoginRequest,
    LoginResponse,
    RefreshRequest,
    RegisterRequest,
    User as UserSchema,
)
from app.security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    hash_password,
    verify_password,
)

router = APIRouter(prefix="/api/auth", tags=["auth"])


@router.post("/register", operation_id="register",
             response_model=LoginResponse, status_code=201)
def register(body: RegisterRequest, request: Request,
             db: Session = Depends(get_db)):
    """Registro abierto (decisión v1). 409 si el correo ya existe."""
    limit_register(request)
    email = body.email.lower().strip()
    if db.scalar(select(User).where(User.email == email)) is not None:
        raise HTTPException(
            status_code=409,
            detail={"code": "email_taken",
                    "message": "Ese correo ya está registrado."},
        )
    user = User(
        name=body.name.strip(),
        email=email,
        password_hash=hash_password(body.password),
        role=body.role.value,
    )
    db.add(user)
    db.flush()
    return LoginResponse(
        access_token=create_access_token(user.id, user.role),
        refresh_token=create_refresh_token(user.id, user.role),
        user=UserSchema.model_validate(user),
    )


@router.post("/login", operation_id="login", response_model=LoginResponse)
def login(body: LoginRequest, request: Request, db: Session = Depends(get_db)):
    limit_login(request, body.email)
    user = db.scalar(select(User).where(User.email == body.email.lower().strip()))
    if user is None or not verify_password(body.password, user.password_hash):
        raise HTTPException(
            status_code=401,
            detail={"code": "invalid_credentials",
                    "message": "Correo o contraseña incorrectos."},
        )
    return LoginResponse(
        access_token=create_access_token(user.id, user.role),
        refresh_token=create_refresh_token(user.id, user.role),
        user=UserSchema.model_validate(user),
    )


@router.post("/refresh", operation_id="refreshToken", response_model=LoginResponse)
def refresh(body: RefreshRequest, db: Session = Depends(get_db)):
    payload = decode_token(body.refresh_token, "refresh")
    if payload is None:
        raise HTTPException(
            status_code=401,
            detail={"code": "unauthorized", "message": "Refresh token inválido."},
        )
    user = db.get(User, int(payload["sub"]))
    if user is None:
        raise HTTPException(
            status_code=401,
            detail={"code": "unauthorized", "message": "Usuario no existe."},
        )
    return LoginResponse(
        access_token=create_access_token(user.id, user.role),
        refresh_token=create_refresh_token(user.id, user.role),
        user=UserSchema.model_validate(user),
    )


@router.get("/me", operation_id="getCurrentUser", response_model=UserSchema)
def me(user: User = Depends(get_current_user)):
    return UserSchema.model_validate(user)
