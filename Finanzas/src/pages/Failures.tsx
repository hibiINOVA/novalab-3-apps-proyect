import { useMemo, useState } from "react";
import { useFailures } from "$lib/hooks";
import { formatCurrency, monthLabel } from "$lib/format";
import { Card, CardHeader, CardTitle, CardContent } from "$components/ui";

export function Failures() {
  const now = new Date();
  const defaultMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const [month, setMonth] = useState(defaultMonth);
  const { data: failures = [], isLoading } = useFailures(month);

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando fallas…</div>;

  const totals = useMemo(
    () =>
      failures.reduce(
        (a, f) => ({
          jobs: a.jobs + f.failed_jobs_count,
          grams: a.grams + f.grams_lost,
          money: a.money + f.money_lost,
        }),
        { jobs: 0, grams: 0, money: 0 },
      ),
    [failures],
  );

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <input
          type="month"
          value={month}
          onChange={(e) => setMonth(e.target.value)}
          className="border border-[#D1D5DB] rounded-md px-3 py-2 text-sm"
        />
        <span className="text-[#6B7280] text-sm">{monthLabel(month)}</span>
      </div>

      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">Costo de fallas</h1>
        <p className="text-[#6B7280]">
          Gramos y dinero perdidos en impresiones fallidas (F-08)
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Jobs fallados</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#DC2626]">
              {totals.jobs}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Gramos perdidos</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#DC2626]">
              {totals.grams.toLocaleString("es-MX")} g
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Dinero perdido</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#DC2626]">
              {formatCurrency(totals.money)}
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Detalle por mes</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">Mes</th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Jobs fallados
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Gramos perdidos
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Dinero perdido
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {failures.map((f) => (
                  <tr key={f.month} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">{monthLabel(f.month)}</td>
                    <td className="py-3 tabular-nums text-right">
                      {f.failed_jobs_count}
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {f.grams_lost.toLocaleString("es-MX")} g
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      {formatCurrency(f.money_lost)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {failures.length === 0 && (
            <div className="p-6 text-center text-[#6B7280]">
              No hay fallas registradas en este mes.
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
