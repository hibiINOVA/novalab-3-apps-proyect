"""JWT (access/refresh), hash de contraseñas (PBKDF2) y cifrado de secrets.

BE-17: roles owner/operator viajan en el token y se validan en deps.
BE-20: API keys de OctoPrint cifradas en reposo (Fernet, key derivada).
"""

import base64
import hashlib
import hmac
import secrets
from datetime import UTC, datetime, timedelta

import jwt
from cryptography.fernet import Fernet, InvalidToken

from app.config import settings

ALGORITHM = "HS256"
_PBKDF2_ITERATIONS = 390_000
_FERNET_PREFIX = "fernet:"


def _secret() -> str:
    return settings.jwt_secret or "novalab-dev-secret-change-me"


def _fernet() -> Fernet:
    """BE-20: clave Fernet derivada de secret_key (o jwt_secret en dev)."""
    seed = settings.secret_key or _secret()
    digest = hashlib.sha256(seed.encode()).digest()
    return Fernet(base64.urlsafe_b64encode(digest))


def encrypt_secret(plain: str | None) -> str | None:
    """Cifra para almacenar. None/vacío pasa tal cual."""
    if not plain:
        return plain
    return _FERNET_PREFIX + _fernet().encrypt(plain.encode()).decode()


def decrypt_secret(stored: str | None) -> str | None:
    """Descifra un valor almacenado. Tolera plaintext heredado (dev/demo)."""
    if not stored:
        return stored
    if not stored.startswith(_FERNET_PREFIX):
        return stored  # legado sin cifrar (seed/demo)
    try:
        return _fernet().decrypt(
            stored[len(_FERNET_PREFIX):].encode()
        ).decode()
    except InvalidToken:
        return None  # key distinta o dato corrupto


def hash_password(password: str) -> str:
    salt = secrets.token_hex(16)
    digest = hashlib.pbkdf2_hmac(
        "sha256", password.encode(), salt.encode(), _PBKDF2_ITERATIONS
    ).hex()
    return f"pbkdf2_sha256${_PBKDF2_ITERATIONS}${salt}${digest}"


def verify_password(password: str, stored: str) -> bool:
    try:
        _, iterations, salt, digest = stored.split("$")
        candidate = hashlib.pbkdf2_hmac(
            "sha256", password.encode(), salt.encode(), int(iterations)
        ).hex()
        return hmac.compare_digest(candidate, digest)
    except (ValueError, TypeError):
        return False


def _create(sub: int, role: str, token_type: str, ttl: timedelta) -> str:
    now = datetime.now(UTC)
    payload = {
        "sub": str(sub),
        "role": role,
        "type": token_type,
        "iat": now,
        "exp": now + ttl,
        "jti": secrets.token_hex(8),
    }
    return jwt.encode(payload, _secret(), algorithm=ALGORITHM)


def create_access_token(user_id: int, role: str) -> str:
    return _create(user_id, role, "access", timedelta(minutes=settings.access_token_minutes))


def create_refresh_token(user_id: int, role: str) -> str:
    return _create(user_id, role, "refresh", timedelta(days=settings.refresh_token_days))


def decode_token(token: str, expected_type: str = "access") -> dict | None:
    """Decodifica y valida. Devuelve el payload o None si es inválido."""
    try:
        payload = jwt.decode(token, _secret(), algorithms=[ALGORITHM])
    except jwt.PyJWTError:
        return None
    if payload.get("type") != expected_type:
        return None
    return payload


def new_tracking_token() -> str:
    """BE-18: token aleatorio y largo, nunca el folio secuencial."""
    return secrets.token_urlsafe(24)


def random_folio(next_id: int) -> str:
    return f"NL-{next_id}"
