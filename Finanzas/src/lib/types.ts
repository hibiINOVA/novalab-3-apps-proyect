/** Tipos de respuesta de la API de finanzas (contrato /api/finance/*).
 *  Los cálculos (fórmulas §3.8) viven exclusivamente en el backend; este
 *  frontend solo presenta lo que devuelve la API.
 */

export type FinanceCategory =
  "luz" | "empaque" | "envio" | "comisiones" | "mantenimiento" | "otro";

export interface FinanceSummary {
  month: string; // YYYY-MM
  orders_count: number;
  income: number; // total facturado (suma de totales de pedidos)
  costs: number; // suma de costos de pedidos + gastos
  profit: number; // income - costs
  margin: number; // profit / income
  previous_month_profit: number;
  variation_pct: number; // (profit - prev) / prev
  goal: number; // meta mensual configurada
  goal_reached: number; // profit alcanzado vs meta
  goal_missing: number; // max(0, goal - profit)
}

export interface FinanceOrderCostBreakdown {
  material: number;
  light: number;
  packaging: number;
  shipping: number;
  commissions: number;
  other: number;
}

export interface FinanceOrder {
  id: number;
  folio: string;
  customer_name: string;
  status: string;
  total: number;
  income: number;
  costs: FinanceOrderCostBreakdown;
  profit: number;
  margin: number;
  created_at: string;
  promised_date?: string | null;
}

export interface FinanceTrendPoint {
  month: string; // YYYY-MM
  income: number;
  costs: number;
  profit: number;
}

export interface FinanceProduct {
  product_id: number;
  product_name: string;
  orders_count: number;
  income: number;
  costs: number;
  profit: number;
  margin: number;
}

export interface FinanceFailure {
  month: string;
  failed_jobs_count: number;
  grams_lost: number;
  money_lost: number;
}

export interface Expense {
  id: number;
  date: string; // YYYY-MM-DD
  category: FinanceCategory;
  amount: number;
  order_id?: number | null;
  order_folio?: string | null;
  created_at: string;
}

export interface ExpenseCreateRequest {
  date: string;
  category: FinanceCategory;
  amount: number;
  order_id?: number | null;
}

export interface ExpenseUpdateRequest {
  date?: string;
  category?: FinanceCategory;
  amount?: number;
  order_id?: number | null;
}

export interface MonthlyGoal {
  month: string; // YYYY-MM
  goal_amount: number;
  tariff_kwh: number;
}

export interface MonthlyGoalUpdate {
  goal_amount?: number;
  tariff_kwh?: number;
}

export interface Branding {
  business_name: string;
  logo_url?: string | null;
  primary_color: string;
  accent_color: string;
  background_color: string;
  currency: string;
  timezone: string;
  language: string;
}

export interface User {
  id: number;
  name: string;
  email: string;
  role: "owner" | "operator";
  organization_id?: number | null;
  membership_status: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  access_token: string;
  refresh_token: string;
  token_type: string;
  user: User;
}

export interface ErrorBody {
  code: string;
  message: string;
}
