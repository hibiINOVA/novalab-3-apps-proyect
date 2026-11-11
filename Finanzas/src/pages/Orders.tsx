import { useState, useMemo } from "react";
import { useOrders } from "$lib/hooks";
import { formatDateISO, formatPercent, monthLabel } from "$lib/format";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  Badge,
  Money,
} from "$components/ui";

const STATUS_ORDER: Record<string, number> = {
  confirmed: 0,
  queued: 1,
  printing: 2,
  printed: 3,
  packed: 4,
  shipped: 5,
  delivered: 6,
  cancelled: 7,
};

export function csvExport(filename: string, headers: string[], rows: any[][]) {
  const esc = (v: any) => {
    const s = String(v ?? "");
    return /[,"\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  const csv = [headers, ...rows.map((r) => r.map(esc).join(","))].join("\n");
  const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

export function Orders() {
  const now = new Date();
  const defaultMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const [month, setMonth] = useState(defaultMonth);
  const [statusFilter, setStatusFilter] = useState<string>("");
  const [q, setQ] = useState("");
  const [sort, setSort] = useState<"folio" | "total" | "created">("folio");
  const [dir, setDir] = useState<"asc" | "desc">("asc");

  const {
    data: orders = [],
    isLoading,
    error,
  } = useOrders({
    month,
    status: statusFilter || undefined,
    q: q || undefined,
  });

  const sorted = useMemo(() => {
    return [...orders].sort((a, b) => {
      let cmp = 0;
      if (sort === "folio") cmp = a.folio.localeCompare(b.folio);
      else if (sort === "total") cmp = a.total - b.total;
      else cmp = a.created_at.localeCompare(b.created_at);
      return dir === "asc" ? cmp : -cmp;
    });
  }, [orders, sort, dir]);

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando pedidos…</div>;
  if (error)
    return (
      <div className="p-6 text-[#DC2626]">
        {error instanceof Error ? error.message : String(error)}
      </div>
    );

  const headers = [
    "Folio",
    "Cliente",
    "Estado",
    "Fecha",
    "Total",
    "Material",
    "Luz",
    "Empaque",
    "Envío",
    "Comisiones",
    "Otros",
    "Ganancia",
    "Margen",
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-col lg:flex-row gap-4 items-end lg:items-center">
        <div>
          <h1 className="text-2xl font-bold text-[#0B132B]">Pedidos</h1>
          <p className="text-[#6B7280]">{monthLabel(month)}</p>
        </div>
        <div className="ml-auto flex flex-col sm:flex-row gap-2">
          <button
            onClick={() =>
              csvExport(
                `pedidos-${month}.csv`,
                headers,
                sorted.map((o) => [
                  o.folio,
                  o.customer_name,
                  o.status,
                  o.created_at,
                  o.total,
                  o.costs.material,
                  o.costs.light,
                  o.costs.packaging,
                  o.costs.shipping,
                  o.costs.commissions,
                  o.costs.other,
                  o.profit,
                  o.margin,
                ]),
              )
            }
            className="px-4 py-2 bg-[#0B132B] text-white rounded-md text-sm font-semibold flex items-center gap-2"
          >
            <svg
              className="w-4 h-4"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1"
              />
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M8 10H1M4 16V5a2 2 0 012-2h10a2 2 0 012 2v11"
              />
            </svg>
            Exportar CSV
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-4">
        <div className="relative">
          <input
            type="month"
            value={month}
            onChange={(e) => setMonth(e.target.value)}
            className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 text-sm bg-white"
          />
        </div>
        <div className="relative">
          <input
            type="text"
            placeholder="Filtrar por folio o cliente"
            value={q}
            onChange={(e) => setQ(e.target.value)}
            className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 text-sm bg-white"
          />
        </div>
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 text-sm bg-white"
        >
          <option value="">Todos los estados</option>
          {Object.keys(STATUS_ORDER).map((s) => (
            <option key={s} value={s}>
              {s.charAt(0).toUpperCase() + s.slice(1)}
            </option>
          ))}
        </select>
        <div className="flex items-end">
          <button
            onClick={() => setDir(dir === "asc" ? "desc" : "asc")}
            className="px-4 py-2 border border-[#D1D5DB] rounded-md text-sm bg-white hover:bg-[#F3F4F6]"
          >
            {dir === "asc" ? "↓" : "↑"}
          </button>
        </div>
      </div>

      <Card>
        <CardHeader>
          <div className="flex justify-between items-baseline">
            <CardTitle>{sorted.length} pedido(s)</CardTitle>
          </div>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th
                    className="pb-3 text-[#6B7280] font-semibold cursor-pointer hover:text-[#0B132B]"
                    onClick={() => setSort("folio")}
                  >
                    Folio
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Cliente</th>
                  <th
                    className="pb-3 text-[#6B7280] font-semibold cursor-pointer hover:text-[#0B132B]"
                    onClick={() => setSort("total")}
                  >
                    Total
                  </th>
                  <th
                    className="pb-3 text-[#6B7280] font-semibold cursor-pointer hover:text-[#0B132B]"
                    onClick={() => setSort("created")}
                  >
                    Fecha
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Estado</th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Ganancia
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Margen
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {sorted.map((o) => (
                  <tr key={o.id} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">{o.folio}</td>
                    <td className="py-3">{o.customer_name}</td>
                    <td className="py-3 tabular-nums font-medium">
                      <Money value={o.total} />
                    </td>
                    <td className="py-3 text-[#6B7280]">
                      {formatDateISO(o.created_at)}
                    </td>
                    <td className="py-3">
                      <Badge variant="default">{o.status}</Badge>
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={o.profit} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      <Badge variant={o.margin >= 0 ? "success" : "danger"}>
                        {formatPercent(o.margin)}
                      </Badge>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {sorted.length === 0 && (
            <div className="p-6 text-center text-[#6B7280]">
              No hay pedidos en este periodo.
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
