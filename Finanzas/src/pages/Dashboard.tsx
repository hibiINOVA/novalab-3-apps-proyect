import { useSummary, useGoal, useUpdateGoal } from "$lib/hooks";
import { formatCurrency, formatPercent, monthLabel } from "$lib/format";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Badge,
  Money,
} from "$components/ui";

export function Dashboard() {
  const now = new Date();
  const month = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const selectedMonth = month;

  const { data: summary, isLoading: loadingSummary } =
    useSummary(selectedMonth);
  const { data: goal, isPending: savingGoal } = useGoal(selectedMonth);
  const goalMutation = useUpdateGoal();

  if (loadingSummary) {
    return (
      <div className="flex h-full items-center justify-center">
        <div className="flex flex-col items-center gap-2 animate-pulse">
          <div className="w-12 h-12 rounded-full bg-[#0B132B]" />
          <p className="text-sm text-[#6B7280]">Cargando resumen…</p>
        </div>
      </div>
    );
  }

  const variation = summary?.variation_pct ?? 0;
  const variationTrend = variation >= 0 ? "up" : "down";
  const missing = summary?.goal_missing ?? 0;
  const progress = summary?.goal
    ? Math.min(100, (summary.goal_reached / summary.goal) * 100)
    : 0;

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">Resumen mensual</h1>
        <p className="text-[#6B7280]">{monthLabel(selectedMonth)}</p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Pedidos</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {summary?.orders_count ?? 0}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Ingresos</CardTitle>
          </CardHeader>
          <CardContent>
            <Money
              value={summary?.income ?? 0}
              className="text-2xl font-bold"
            />
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Costos</CardTitle>
          </CardHeader>
          <CardContent>
            <Money value={summary?.costs ?? 0} className="text-2xl font-bold" />
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Ganancia</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              <Money value={summary?.profit ?? 0} />
            </div>
            <div className="text-xs mt-1">
              <Badge variant={summary?.margin! >= 0 ? "success" : "danger"}>
                Margen {formatPercent(summary?.margin ?? 0)}
              </Badge>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Comparativa mes anterior</CardTitle>
          </CardHeader>
          <CardContent className="flex flex-col items-center justify-center gap-3">
            <div className="text-4xl font-bold">
              {formatPercent(Math.abs(variation))}
              <span className="text-lg ml-1">
                {variationTrend === "up" ? "▲" : "▼"}
              </span>
            </div>
            <p
              className={`text-sm font-medium ${variationTrend === "up" ? "text-[#059669]" : "text-[#DC2626]"}`}
            >
              {variationTrend === "up" ? "subió" : "bajó"} vs mes anterior
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Meta mensual</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex justify-between text-sm text-[#6B7280]">
              <span>Avance</span>
              <span>{formatPercent(progress)}</span>
            </div>
            <div className="w-full bg-[#E5E7EB] rounded-full h-2">
              <div
                className="h-2 rounded-full bg-[#00FF87]"
                style={{ width: `${progress}%` }}
              />
            </div>
            <div className="flex justify-between text-sm">
              <span>Alcanzado</span>
              <span>
                <Money value={summary?.goal_reached ?? 0} />
              </span>
            </div>
            {missing > 0 ? (
              <div className="flex justify-between text-sm text-[#DC2626] font-medium">
                <span>Te faltan</span>
                <span>{formatCurrency(missing)} para tu meta</span>
              </div>
            ) : (
              <div className="flex justify-between text-sm text-[#059669] font-medium">
                <span>Meta</span>
                <span>cumplida ✓</span>
              </div>
            )}
            <div className="pt-2 flex gap-2">
              <input
                type="number"
                step="0.01"
                defaultValue={goal?.goal_amount?.toString() ?? ""}
                className="flex-1 border border-[#D1D5DB] rounded-md px-3 py-2 text-sm"
                onBlur={(e) => {
                  const v = parseFloat(e.target.value);
                  if (!isNaN(v)) {
                    goalMutation.mutate({
                      month: selectedMonth,
                      body: { goal_amount: v },
                    });
                  }
                }}
              />
              <button
                disabled={savingGoal}
                className="px-4 py-2 bg-[#0B132B] text-white rounded-md text-sm font-semibold disabled:opacity-60"
              >
                Guardar meta
              </button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
