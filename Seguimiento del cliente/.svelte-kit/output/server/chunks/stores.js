import { w as writable } from "./index2.js";
const API_BASE = "/api/public";
class ApiError extends Error {
  constructor(status, body) {
    super(body.message);
    this.status = status;
    this.body = body;
    this.name = "ApiError";
  }
}
async function request(input, init) {
  const res = await fetch(input, {
    headers: { Accept: "application/json", ...init?.headers ?? {} },
    ...init
  });
  if (!res.ok) {
    let body = { code: "error", message: `Error ${res.status}` };
    try {
      body = await res.json();
    } catch {
    }
    throw new ApiError(res.status, body);
  }
  const ct = res.headers.get("content-type") ?? "";
  if (ct.includes("application/json")) {
    return await res.json();
  }
  return await res.text();
}
const publicApi = {
  getBranding: () => request(`${API_BASE}/branding`),
  getTrack: (token) => request(`${API_BASE}/track/${encodeURIComponent(token)}`),
  getTrackCamera: (token) => fetch(`${API_BASE}/track/${encodeURIComponent(token)}/camera`),
  lookup: (body) => request(`${API_BASE}/lookup`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body)
  })
};
const order = writable(null);
const branding = writable(null);
const error = writable(null);
const loading = writable(false);
export {
  ApiError as A,
  branding as b,
  error as e,
  loading as l,
  order as o,
  publicApi as p
};
