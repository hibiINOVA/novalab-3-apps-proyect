import { useMembers } from "$lib/hooks";
import { formatDateISO } from "$lib/format";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  Badge,
} from "$components/ui";

const ROLE_LABELS: Record<string, string> = {
  owner: "Dueño",
  operator: "Operador",
};

const STATUS_LABELS: Record<string, string> = {
  active: "Activo",
  pending: "Pendiente",
  rejected: "Rechazado",
};

export function Users() {
  const { data: members = [], isLoading } = useMembers();

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando miembros…</div>;

  const owners = members.filter((m) => m.role === "owner").length;
  const operators = members.filter((m) => m.role === "operator").length;
  const active = members.filter((m) => m.status === "active").length;
  const pending = members.filter((m) => m.status === "pending").length;

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">
          Miembros de la organización
        </h1>
        <p className="text-[#6B7280]">
          Usuarios con acceso a la organización y sus roles (multi-tenant).
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-4 gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Miembros totales</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">
              {members.length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Dueños</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">{owners}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Operadores</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#0B132B]">{operators}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Activos</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#059669]">{active}</div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{members.length} miembro(s)</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">Usuario</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Correo</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Rol</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Estado</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Org.</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">Desde</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {members.map((m) => (
                  <tr key={m.id} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">{m.user_name}</td>
                    <td className="py-3 text-[#6B7280]">{m.user_email}</td>
                    <td className="py-3">
                      <Badge variant="default">{ROLE_LABELS[m.role]}</Badge>
                    </td>
                    <td className="py-3">
                      <Badge
                        variant={
                          m.status === "active"
                            ? "success"
                            : m.status === "pending"
                              ? "warning"
                              : "danger"
                        }
                      >
                        {STATUS_LABELS[m.status]}
                      </Badge>
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {m.organization_code ?? "—"}
                    </td>
                    <td className="py-3 text-[#6B7280]">
                      {m.created_at ? formatDateISO(m.created_at) : "—"}
                    </td>
                  </tr>
                ))}
                {members.length === 0 && (
                  <tr>
                    <td colSpan={6} className="p-6 text-center text-[#6B7280]">
                      No hay miembros activos en esta organización.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>

      {pending > 0 && (
        <Card>
          <CardHeader>
            <CardTitle>Solicitudes pendientes ({pending})</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-[#6B7280]">
              Hay {pending} solicitud(es) de operador(es) esperando aprobación.
              Usa la app de Producción (pestaña de organización) para aceptarlas
              o rechazarlas.
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
