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

export interface Shipment {
  carrier: string;
  tracking_number?: string | null;
  tracking_url?: string | null;
  shipped_at?: string | null;
  delivered_at?: string | null;
}

export interface OrderItem {
  id: number;
  product_id: number;
  product_name: string;
  color?: string | null;
  quantity: number;
  printed_quantity: number;
  missing_quantity: number;
  state: 'pending' | 'queued' | 'printing' | 'printed' | 'failed';
  printer_id?: number | null;
  printer_name?: string | null;
}

export interface StatusHistoryEntry {
  status: string;
  previous_status?: string | null;
  user_name?: string | null;
  occurred_at: string;
}

export interface OrderDetail {
  id: number;
  folio: string;
  customer_name: string;
  status: string;
  promised_date?: string | null;
  due_state?: 'none' | 'ok' | 'due_soon' | 'overdue';
  total: number;
  items_count: number;
  printed_count: number;
  created_at: string;
  tracking_token: string;
  notes?: string | null;
  customer: any | null;
  items: OrderItem[];
  history: StatusHistoryEntry[];
  shipment?: Shipment | null;
}

export interface PublicLookupRequest {
  folio: string;
  phone_last4: string;
}

export interface PublicLookupResponse {
  tracking_token: string;
}

export interface ErrorBody {
  code: string;
  message: string;
}

export const ORDER_TIMELINE = [
  'confirmed',
  'queued',
  'printing',
  'printed',
  'packed',
  'shipped',
  'delivered',
] as const;

export const STATUS_LABELS: Record<string, string> = {
  confirmed: 'Confirmado',
  queued: 'En cola',
  printing: 'Imprimiendo',
  printed: 'Impreso',
  packed: 'Empacado',
  shipped: 'Enviado',
  delivered: 'Entregado',
  cancelled: 'Cancelado',
};

export function labelFor(status: string | undefined): string {
  return STATUS_LABELS[status ?? ''] ?? status ?? '—';
}

export const DUE_STATE_LABELS: Record<string, string> = {
  none: '',
  ok: '',
  due_soon: 'Próximo a vencer',
  overdue: 'Vencido',
};
