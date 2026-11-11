import type {
  Branding,
  OrderDetail,
  PublicLookupRequest,
  PublicLookupResponse,
  ErrorBody,
} from '$lib/types';

const API_BASE = import.meta.env.VITE_API_BASE_URL ?? '/api/public';

class ApiError extends Error {
  constructor(
    public status: number,
    public body: ErrorBody,
  ) {
    super(body.message);
    this.name = 'ApiError';
  }
}

async function request<T>(
  input: RequestInfo | URL,
  init?: RequestInit,
): Promise<T> {
  const res = await fetch(input, {
    headers: { Accept: 'application/json', ...(init?.headers ?? {}) },
    ...init,
  });
  if (!res.ok) {
    let body: ErrorBody = { code: 'error', message: `Error ${res.status}` };
    try {
      body = (await res.json()) as ErrorBody;
    } catch {
      // ignore
    }
    throw new ApiError(res.status, body);
  }
  const ct = res.headers.get('content-type') ?? '';
  if (ct.includes('application/json')) {
    return (await res.json()) as T;
  }
  return (await res.text()) as unknown as T;
}

export const publicApi = {
  getBranding: () => request<Branding>(`${API_BASE}/branding`),

  getTrack: (token: string) =>
    request<OrderDetail>(`${API_BASE}/track/${encodeURIComponent(token)}`),

  getTrackCamera: (token: string) =>
    fetch(`${API_BASE}/track/${encodeURIComponent(token)}/camera`),

  lookup: (body: PublicLookupRequest) =>
    request<PublicLookupResponse>(`${API_BASE}/lookup`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    }),
};

export { ApiError };
