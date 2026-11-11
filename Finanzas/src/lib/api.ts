/// <reference types="vite/client" />
import type {
  FinanceSummary,
  FinanceOrder,
  FinanceTrendPoint,
  FinanceProduct,
  FinanceFailure,
  Expense,
  ExpenseCreateRequest,
  ExpenseUpdateRequest,
  MonthlyGoal,
  MonthlyGoalUpdate,
  Branding,
  LoginRequest,
  LoginResponse,
  ErrorBody,
} from "$lib/types";

const API_BASE = import.meta.env.VITE_API_BASE_URL ?? "/api";

class ApiError extends Error {
  constructor(
    public status: number,
    public body: ErrorBody,
  ) {
    super(body.message);
    this.name = "ApiError";
  }
}

async function request<T>(
  input: RequestInfo | URL,
  init?: RequestInit,
): Promise<T> {
  const token =
    typeof localStorage !== "undefined"
      ? localStorage.getItem("nv_token")
      : null;
  const res = await fetch(input, {
    headers: {
      Accept: "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(init?.headers ?? {}),
    },
    ...init,
  });
  if (!res.ok) {
    let body: ErrorBody = { code: "error", message: `Error ${res.status}` };
    try {
      body = (await res.json()) as ErrorBody;
    } catch {
      // ignore
    }
    throw new ApiError(res.status, body);
  }
  const ct = res.headers.get("content-type") ?? "";
  if (ct.includes("application/json")) {
    return (await res.json()) as T;
  }
  return (await res.text()) as unknown as T;
}

export const financeApi = {
  login: (body: LoginRequest) =>
    request<LoginResponse>(`${API_BASE}/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),

  getBranding: () => request<Branding>(`${API_BASE}/public/branding`),

  getSummary: (month: string) =>
    request<FinanceSummary>(`${API_BASE}/finance/summary?month=${month}`),

  getOrders: (params?: { month?: string; status?: string; q?: string }) => {
    const qs = new URLSearchParams();
    if (params?.month) qs.set("month", params.month);
    if (params?.status) qs.set("status", params.status);
    if (params?.q) qs.set("q", params.q);
    return request<FinanceOrder[]>(`${API_BASE}/finance/orders?${qs}`);
  },

  getTrend: () => request<FinanceTrendPoint[]>(`${API_BASE}/finance/trend`),

  getProducts: () => request<FinanceProduct[]>(`${API_BASE}/finance/products`),

  getFailures: (month: string) =>
    request<FinanceFailure[]>(`${API_BASE}/finance/failures?month=${month}`),

  getExpenses: (month?: string) => {
    const qs = month ? `?month=${month}` : "";
    return request<Expense[]>(`${API_BASE}/finance/expenses${qs}`);
  },

  createExpense: (body: ExpenseCreateRequest) =>
    request<Expense>(`${API_BASE}/finance/expenses`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),

  updateExpense: (id: number, body: ExpenseUpdateRequest) =>
    request<Expense>(`${API_BASE}/finance/expenses/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),

  deleteExpense: (id: number) =>
    request<void>(`${API_BASE}/finance/expenses/${id}`, {
      method: "DELETE",
    }),

  getGoal: (month: string) =>
    request<MonthlyGoal>(`${API_BASE}/finance/goal?month=${month}`),

  updateGoal: (month: string, body: MonthlyGoalUpdate) =>
    request<MonthlyGoal>(`${API_BASE}/finance/goal?month=${month}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),
};

export { ApiError };
