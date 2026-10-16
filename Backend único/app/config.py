"""Configuración vía variables de entorno (prefijo NOVALAB_)."""

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    db_url: str = "sqlite:///data/novalab.db"
    jwt_secret: str = ""  # vacío → secreto dev (ver app.security)
    access_token_minutes: int = 60
    refresh_token_days: int = 14
    cors_origins: str = (
        "http://localhost:5173,http://localhost:8080,"
        "http://localhost:4173,http://localhost:5000"
    )
    poll_interval_printing: int = 5   # BE-02
    poll_interval_idle: int = 30      # BE-02
    snapshot_interval: int = 12       # BE-07
    due_soon_days: int = 3
    seed_demo: bool = True

    @property
    def cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.cors_origins.split(",") if o.strip()]

    class Config:
        env_prefix = "NOVALAB_"
        env_file = ".env"


settings = Settings()
