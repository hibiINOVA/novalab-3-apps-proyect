import { useState } from "react";
import {
  useExpenses,
  useCreateExpense,
  useUpdateExpense,
  useDeleteExpense,
} from "$lib/hooks";
import { formatDateISO } from "$lib/format";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  Badge,
  Money,
} from "$components/ui";

const CATEGORY_LABELS: Record<string, string> = {
  luz: "Luz",
  empaque: "Empaque",
  envio: "Envío",
  comisiones: "Comisiones",
  mantenimiento: "Mantenimiento",
  otro: "Otro",
};

export function Expenses() {
  const now = new Date();
  const defaultMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const [month, setMonth] = useState(defaultMonth);
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<{ id: number } | null>(null);
  const [date, setDate] = useState("");
  const [category, setCategory] = useState<
    "luz" | "empaque" | "envio" | "comisiones" | "mantenimiento" | "otro"
  >("otro");
  const [amount, setAmount] = useState("");
  const [orderId, setOrderId] = useState("");

  const { data: expenses = [], isLoading } = useExpenses(month);
  const create = useCreateExpense();
  const update = useUpdateExpense();
  const remove = useDeleteExpense();

  const total = expenses.reduce((s, e) => s + e.amount, 0);

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    const body = {
      date,
      category,
      amount: parseFloat(amount),
      order_id: orderId ? parseInt(orderId, 10) : undefined,
    };
    if (editing) {
      update.mutate({ id: editing.id, body });
    } else {
      create.mutate(body);
    }
    setOpen(false);
    setEditing(null);
    setDate("");
    setAmount("");
    setOrderId("");
  };

  const categories: { value: string; label: string }[] = [
    { value: "luz", label: "Luz" },
    { value: "empaque", label: "Empaque" },
    { value: "envio", label: "Envío" },
    { value: "comisiones", label: "Comisiones" },
    { value: "mantenimiento", label: "Mantenimiento" },
    { value: "otro", label: "Otro" },
  ];

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando gastos…</div>;

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row gap-3 items-end sm:items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-[#0B132B]">Gastos</h1>
          <p className="text-[#6B7280]">
            Alta, edición y baja con categorías (F-09)
          </p>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => {
              setEditing(null);
              setDate("");
              setCategory("otro");
              setAmount("");
              setOrderId("");
              setOpen(true);
            }}
            className="px-4 py-2 bg-[#0B132B] text-white rounded-md text-sm font-semibold"
          >
            Nuevo gasto
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div className="relative">
          <input
            type="month"
            value={month}
            onChange={(e) => setMonth(e.target.value)}
            className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 text-sm bg-white"
          />
        </div>
        <Card>
          <CardHeader>
            <CardTitle>Total del mes</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              <Money value={total} />
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{expenses.length} gasto(s)</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">Fecha</th>
                  <th className="pb-3 text-[#6B7280] font-semibold">
                    Categoría
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Monto
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Pedido
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Acciones
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {expenses.map((e) => (
                  <tr key={e.id} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">
                      {formatDateISO(e.date)}
                    </td>
                    <td className="py-3">
                      <Badge variant="muted">
                        {CATEGORY_LABELS[e.category]}
                      </Badge>
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={e.amount} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      {e.order_folio ?? "—"}
                    </td>
                    <td className="py-3 text-right">
                      <button
                        onClick={() => {
                          setEditing({ id: e.id });
                          setDate(e.date);
                          setCategory(e.category);
                          setAmount(e.amount.toString());
                          setOrderId(e.order_id?.toString() ?? "");
                          setOpen(true);
                        }}
                        className="text-[#0B132B] text-sm underline"
                      >
                        Editar
                      </button>
                      <button
                        onClick={() => remove.mutate(e.id)}
                        className="ml-2 text-[#DC2626] text-sm underline"
                      >
                        Eliminar
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {expenses.length === 0 && (
            <div className="p-6 text-center text-[#6B7280]">
              No hay gastos registrados en este mes.
            </div>
          )}
        </CardContent>
      </Card>

      {/* Form modal (simple overlay) */}
      {open && (
        <div
          className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4"
          onClick={() => setOpen(false)}
        >
          <Card className="w-full max-w-md bg-white shadow-xl">
            <CardHeader>
              <CardTitle>{editing ? "Editar gasto" : "Nuevo gasto"}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <form onSubmit={handleSave}>
                <div>
                  <label className="block text-sm font-medium text-[#6B7280] mb-1">
                    Fecha
                  </label>
                  <input
                    type="date"
                    required
                    value={date}
                    onChange={(e) => setDate(e.target.value)}
                    className="w-full border border-[#D1D5DB] rounded-md px-3 py-2"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-[#6B7280] mb-1">
                    Categoría
                  </label>
                  <select
                    value={category}
                    onChange={(e) => setCategory(e.target.value as any)}
                    className="w-full border border-[#D1D5DB] rounded-md px-3 py-2"
                  >
                    {categories.map((c) => (
                      <option key={c.value} value={c.value}>
                        {c.label}
                      </option>
                    ))}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-[#6B7280] mb-1">
                    Monto
                  </label>
                  <input
                    type="number"
                    step="0.01"
                    required
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    className="w-full border border-[#D1D5DB] rounded-md px-3 py-2"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-[#6B7280] mb-1">
                    Pedido (opcional, ID)
                  </label>
                  <input
                    type="number"
                    value={orderId}
                    onChange={(e) => setOrderId(e.target.value)}
                    className="w-full border border-[#D1D5DB] rounded-md px-3 py-2"
                    placeholder="ID del pedido"
                  />
                </div>
                <div className="flex justify-end gap-2 pt-2">
                  <button
                    type="button"
                    onClick={() => setOpen(false)}
                    className="px-4 py-2 border border-[#D1D5DB] rounded-md text-sm text-[#6B7280]"
                  >
                    Cancelar
                  </button>
                  <button
                    type="submit"
                    disabled={create.isPending || update.isPending}
                    className="px-4 py-2 bg-[#0B132B] text-white rounded-md text-sm font-semibold disabled:opacity-60"
                  >
                    Guardar
                  </button>
                </div>
              </form>
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  );
}
