"""Límite de peticiones en memoria (BE-19: login y lookup).

Ventana deslizante por clave (IP o IP+email). Suficiente para una instalación
single-tenant; sin dependencias externas.
"""

import time
from collections import defaultdict, deque

DEFAULT_WINDOW_SECONDS = 300
DEFAULT_MAX_HITS = 10


class RateLimiter:
    def __init__(self, max_hits: int = DEFAULT_MAX_HITS, window: int = DEFAULT_WINDOW_SECONDS):
        self.max_hits = max_hits
        self.window = window
        self._hits: dict[str, deque[float]] = defaultdict(deque)

    def check(self, key: str) -> bool:
        """True si la petición está permitida (registra el intento)."""
        now = time.monotonic()
        bucket = self._hits[key]
        while bucket and now - bucket[0] > self.window:
            bucket.popleft()
        if len(bucket) >= self.max_hits:
            return False
        bucket.append(now)
        return True

    def reset(self) -> None:
        self._hits.clear()


login_limiter = RateLimiter(max_hits=10, window=300)
register_limiter = RateLimiter(max_hits=5, window=300)
lookup_limiter = RateLimiter(max_hits=10, window=300)
public_limiter = RateLimiter(max_hits=120, window=60)
