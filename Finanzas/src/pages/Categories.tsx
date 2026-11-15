import { useMemo, useState } from "react";
import { useOrders } from "$lib/hooks";
import { formatCurrency } from "$lib/format";
import { Card, CardHeader, CardTitle, CardContent } from "$components/ui";

const CATEGORY_LABELS: Record<string, string> = {
  luz: "Luz",
  empaque: "Empaque",
  envio: "Envío",
  comisiones: "Comisiones",
  mantenimiento: "Mantenimiento",
  otro: "Otro",
};

const CATEGORY_COLORS: Record<string, string> = {
  luz: "#F59E0B",
  empaque: "#3B82F6",
  envio: "#8B5CF6",
  comisiones: "#EC4899",
  mantenimiento: "#10B981",
  otro: "#6B7280",
};

const BREAKDOWN_TO_CATEGORY: Record<string, string> = {
  material: "otro",
  light: "luz",
  packaging: "empaque",
  shipping: "envio",
  commissions: "comisiones",
  other: "otro",
};

export function Categories() {
  const now = new Date();
  const defaultMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const [month, setMonth] = useState(defaultMonth);

  const { data: orders = [], isLoading } = useOrders({ month });

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando desglose…</div>;

  const breakdown = useMemo(() => {
    const totals: Record<string, { amount: number; count: number }> = {};
    orders.forEach((o) => {
      const c = o.costs;
      const entries: [string, number][] = [
        ["material", c.material],
        ["light", c.light],
        ["packaging", c.packaging],
        ["shipping", c.shipping],
        ["commissions", c.commissions],
        ["other", c.other],
      ];
      for (const [key, value] of entries) {
        if (value > 0) {
          const cat = BREAKDOWN_TO_CATEGORY[key];
          if (!totals[cat]) totals[cat] = { amount: 0, count: 0 };
          totals[cat].amount += value;
          totals[cat].count += 1;
        }
      }
    });
    return totals;
  }, [orders]);

  const entries = Object.entries(breakdown).map(([cat, data]) => ({
    category: cat,
    label: CATEGORY_LABELS[cat] ?? cat,
    amount: data.amount,
    orders_count: data.count,
  }));

  const totalAmount = entries.reduce((s, e) => s + e.amount, 0);

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row gap-3 items-end sm:items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-[#0B132B]">
            Desglose de costos por categoría
          </h1>
          <p className="text-[#6B7280]">
            Cuánto se gasta en cada concepto del mes (material, luz, empaque,
            envío, comisiones, otros).
          </p>
        </div>
        <div className="relative">
          <input
            type="month"
            value={month}
            onChange={(e) => setMonth(e.target.value)}
            className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 text-sm bg-white"
          />
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Costo total del mes</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              <span className="block">{formatCurrency(totalAmount)}</span>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Categorías</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {entries.length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Pedidos con costos</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {
                orders.filter((o) => Object.values(o.costs).some((v) => v > 0))
                  .length
              }
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Detalle por categoría</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">
                    Categoría
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Monto
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    % del total
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Pedidos
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {entries
                  .sort((a, b) => b.amount - a.amount)
                  .map((e) => {
                    const pct =
                      totalAmount > 0 ? (e.amount / totalAmount) * 100 : 0;
                    return (
                      <tr key={e.category} className="hover:bg-[#F9FAFB]">
                        <td className="py-3 font-medium flex items-center gap-2">
                          <span
                            className="w-3 h-3 rounded-full"
                            style={{
                              backgroundColor: CATEGORY_COLORS[e.category],
                            }}
                          />
                          {e.label}
                        </td>
                        <td className="py-3 tabular-nums text-right font-medium">
                          <span className="block">
                            {formatCurrency(e.amount)}
                          </span>
                        </td>
                        <td className="py-3 tabular-nums text-right">
                          {pct.toLocaleString("es-MX", {
                            minimumFractionDigits: 1,
                            maximumFractionDigits: 1,
                          })}
                          %
                        </td>
                        <td className="py-3 tabular-nums text-right">
                          {e.orders_count}
                        </td>
                      </tr>
                    );
                  })}
                {entries.length === 0 && (
                  <tr>
                    <td colSpan={4} className="p-6 text-center text-[#6B7280]">
                      No hay costos registrados en este mes.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
          <p className="mt-4 text-sm text-[#6B7280]">
            Nota: los cálculos de costo por categoría (material, luz, empaque,
            envío, comisiones, otros) residen exclusivamente en el backend
            (§3.8). Esta vista agrega los desgloses devueltos por cada pedido.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
