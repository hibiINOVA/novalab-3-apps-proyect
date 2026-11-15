import { useUserStats } from "$lib/hooks";
import { formatPercent } from "$lib/format";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  Badge,
  Money,
} from "$components/ui";

const ROLE_LABELS: Record<string, string> = {
  owner: "Dueño",
  operator: "Operador",
};

export function UserStats() {
  const { data, isLoading } = useUserStats();

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando estadísticas…</div>;

  const users = data?.users ?? [];

  const totals = users.reduce(
    (a, u) => ({
      orders: a.orders + u.orders_count,
      income: a.income + u.income,
      costs: a.costs + u.costs,
      profit: a.profit + u.profit,
      jobsStarted: a.jobsStarted + u.jobs_started,
      jobsCompleted: a.jobsCompleted + u.jobs_completed,
      jobsFailed: a.jobsFailed + u.jobs_failed,
      minutes: a.minutes + u.minutes_printed,
      grams: a.grams + u.grams_printed,
    }),
    {
      orders: 0,
      income: 0,
      costs: 0,
      profit: 0,
      jobsStarted: 0,
      jobsCompleted: 0,
      jobsFailed: 0,
      minutes: 0,
      grams: 0,
    },
  );

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">
          Estadísticas por usuario
        </h1>
        <p className="text-[#6B7280]">
          Métricas de cada operador de la organización: órdenes, ingresos,
          costos, ganancia y trabajos de impresión.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Usuarios</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {users.length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Órdenes totales</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {totals.orders}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Ingresos totales</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              <Money value={totals.income} />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Ganancia total</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              <Money value={totals.profit} />
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{users.length} usuario(s)</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">Usuario</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Rol</th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Órdenes
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Ingresos
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Costos
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Ganancia
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Margen
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Jobs
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Completados
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Fallados
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Minutos impresos
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {users.map((u) => (
                  <tr key={u.user_id} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">{u.user_name}</td>
                    <td className="py-3 text-[#6B7280]">{u.user_email}</td>
                    <td className="py-3">
                      <Badge variant="default">{ROLE_LABELS[u.role]}</Badge>
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {u.orders_count}
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={u.income} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      <Money value={u.costs} />
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={u.profit} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      <Badge variant={u.margin >= 0 ? "success" : "danger"}>
                        {formatPercent(u.margin)}
                      </Badge>
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {u.jobs_started}
                    </td>
                    <td className="py-3 tabular-nums text-right text-[#059669]">
                      {u.jobs_completed}
                    </td>
                    <td className="py-3 tabular-nums text-right text-[#DC2626]">
                      {u.jobs_failed}
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {u.minutes_printed.toLocaleString("es-MX")}
                    </td>
                  </tr>
                ))}
                {users.length === 0 && (
                  <tr>
                    <td colSpan={11} className="p-6 text-center text-[#6B7280]">
                      No hay estadísticas de usuarios aún.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
          <p className="mt-4 text-sm text-[#6B7280]">
            Nota: las métricas se atribuyen al usuario que creó la orden o
            inició el job de impresión. Requieren que los datos hayan sido
            generados con el backend actualizado (campo `user_id` en órdenes y
            jobs).
          </p>
        </CardContent>
      </Card>

      {totals.jobsStarted > 0 && (
        <Card>
          <CardHeader>
            <CardTitle>Resumen de impresión</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 sm:grid-cols-4 gap-4">
              <Card>
                <CardHeader>
                  <CardTitle>Jobs iniciados</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-[#0B132B]">
                    {totals.jobsStarted}
                  </div>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Completados</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-[#059669]">
                    {totals.jobsCompleted}
                  </div>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Fallados</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-[#DC2626]">
                    {totals.jobsFailed}
                  </div>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Minutos impresos</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold text-[#0B132B]">
                    {totals.minutes.toLocaleString("es-MX")}
                  </div>
                </CardContent>
              </Card>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
