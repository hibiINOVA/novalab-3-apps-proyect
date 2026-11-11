import { useTrend } from "$lib/hooks";
import { formatCurrency, monthLabel } from "$lib/format";
import { Card, CardHeader, CardTitle, CardContent } from "$components/ui";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";

interface CustomTooltipProps {
  active?: boolean;
  payload?: any[];
}

function CustomTooltip({ active, payload }: CustomTooltipProps) {
  if (!active || !payload || !payload.length) return null;
  const p = payload[0].payload as any;
  return (
    <div className="bg-white border border-[#E5E7EB] p-3 rounded shadow">
      <p className="font-bold text-[#0B132B]">{monthLabel(String(p.month))}</p>
      <p>Ingresos: {formatCurrency(p.income)}</p>
      <p>Costos: {formatCurrency(p.costs)}</p>
      <p>Ganancia: {formatCurrency(p.profit)}</p>
    </div>
  );
}

export function Trend() {
  const { data: points = [], isLoading } = useTrend();

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando tendencia…</div>;

  const totalIncome = points.reduce((s, p) => s + p.income, 0);
  const totalCosts = points.reduce((s, p) => s + p.costs, 0);
  const totalProfit = points.reduce((s, p) => s + p.profit, 0);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">
          Tendencia — últimos 12 meses
        </h1>
        <p className="text-[#6B7280]">Ingresos vs costos vs ganancia (F-06)</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Ingresos totales</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#0B132B]">
              <span className="block">{formatCurrency(totalIncome)}</span>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Costos totales</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#0B132B]">
              <span className="block">{formatCurrency(totalCosts)}</span>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Ganancia total</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              <span className="block">{formatCurrency(totalProfit)}</span>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Evolución mensual</CardTitle>
        </CardHeader>
        <CardContent className="h-[360px]">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={points}>
              <CartesianGrid
                strokeDasharray="3 3"
                vertical={false}
                stroke="#E5E7EB"
              />
              <XAxis
                dataKey="month"
                tick={(v) => <span>{monthLabel(String(v))}</span>}
              />
              <YAxis tickFormatter={(v) => formatCurrency(v)} />
              <Tooltip content={CustomTooltip} />
              <Legend />
              <Line
                name="Ingresos"
                type="monotone"
                dataKey="income"
                stroke="#0B132B"
              />
              <Line
                name="Costos"
                type="monotone"
                dataKey="costs"
                stroke="#F59E0B"
              />
              <Line
                name="Ganancia"
                type="monotone"
                dataKey="profit"
                stroke="#00FF87"
              />
            </LineChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>
    </div>
  );
}
