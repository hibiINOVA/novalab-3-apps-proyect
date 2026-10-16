"""Motor SQLite (WAL) y fábrica de sesiones."""

from pathlib import Path

from sqlalchemy import create_engine, event
from sqlalchemy.orm import DeclarativeBase, sessionmaker


class Base(DeclarativeBase):
    pass


def make_engine(url: str):
    if url.startswith("sqlite") and "///" in url:
        raw = url.split("///", 1)[1]
        if raw and raw != ":memory:" and not Path(raw).is_absolute():
            Path(raw).parent.mkdir(parents=True, exist_ok=True)
        engine = create_engine(url, connect_args={"check_same_thread": False})

        @event.listens_for(engine, "connect")
        def _pragmas(dbapi_conn, _record):
            cur = dbapi_conn.cursor()
            cur.execute("PRAGMA journal_mode=WAL")
            cur.execute("PRAGMA foreign_keys=ON")
            cur.close()

        return engine
    return create_engine(url)


_engine = None
_session_factory = None


def init_db(url: str) -> None:
    global _engine, _session_factory
    _engine = make_engine(url)
    _session_factory = sessionmaker(
        bind=_engine, autoflush=False, expire_on_commit=False
    )


def _ensure() -> None:
    if _session_factory is None:
        from app.config import settings

        init_db(settings.db_url)


def get_engine():
    _ensure()
    return _engine


def get_session_factory():
    _ensure()
    return _session_factory


def get_db():
    session = get_session_factory()()
    try:
        yield session
        session.commit()
    except Exception:
        session.rollback()
        raise
    finally:
        session.close()
