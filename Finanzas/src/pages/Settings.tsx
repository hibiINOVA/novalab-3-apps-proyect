import { useState } from "react";
import { useGoal, useUpdateGoal } from "$lib/hooks";
import { formatCurrency } from "$lib/format";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  Money,
} from "$components/ui";

export function Settings() {
  const now = new Date();
  const defaultMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const month = defaultMonth;
  const [goalAmount, setGoalAmount] = useState("");
  const [tariff, setTariff] = useState("");

  const { data: goal } = useGoal(month);
  const { mutate: updateGoal, isPending: saving } = useUpdateGoal();

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    const body: Record<string, number> = {};
    if (goalAmount !== "") body.goal_amount = parseFloat(goalAmount);
    if (tariff !== "") body.tariff_kwh = parseFloat(tariff);
    updateGoal({ month, body });
    setGoalAmount("");
    setTariff("");
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">
          Ajustes de finanzas
        </h1>
        <p className="text-[#6B7280]">Meta mensual y tarifa de luz (F-10)</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Meta mensual ({month})</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div className="flex flex-col">
              <label className="text-sm text-[#6B7280]">Meta de ganancia</label>
              <div className="flex items-end gap-1">
                <span className="text-[#6B7280] text-xs">$</span>
                <input
                  type="number"
                  step="0.01"
                  defaultValue={goal?.goal_amount?.toString() ?? ""}
                  value={goalAmount}
                  onChange={(e) => setGoalAmount(e.target.value)}
                  className="border border-[#D1D5DB] rounded-md px-3 py-2 text-sm font-semibold tabular-nums"
                />
              </div>
            </div>
            <div className="flex flex-col">
              <label className="text-sm text-[#6B7280]">
                Tarifa de luz (kWh)
              </label>
              <div className="flex items-end gap-1">
                <span className="text-[#6B7280] text-xs">$</span>
                <input
                  type="number"
                  step="0.01"
                  defaultValue={goal?.tariff_kwh?.toString() ?? ""}
                  value={tariff}
                  onChange={(e) => setTariff(e.target.value)}
                  className="border border-[#D1D5DB] rounded-md px-3 py-2 text-sm font-semibold tabular-nums"
                />
              </div>
            </div>
            <div className="flex items-end">
              <button
                onClick={handleSave}
                disabled={saving}
                className="px-4 py-2 bg-[#0B132B] text-white rounded-md text-sm font-semibold disabled:opacity-60"
              >
                Guardar
              </button>
            </div>
          </div>

          {goal && (
            <div className="pt-4 border-t border-[#E5E7EB]">
              <div className="flex justify-between text-sm text-[#6B7280] mb-2">
                <span>Meta configurada</span>
                <span>
                  <Money value={goal.goal_amount} />
                </span>
              </div>
              <div className="flex justify-between text-sm text-[#6B7280]">
                <span>Tarifa de luz</span>
                <span>{formatCurrency(goal.tariff_kwh)} / kWh</span>
              </div>
            </div>
          )}
          {saving && <p className="text-sm text-[#6B7280]">Guardando…</p>}
        </CardContent>
      </Card>

      <div className="bg-[#F3F4F6] rounded-xl p-6 border border-[#E5E7EB]">
        <h3 className="text-sm font-semibold text-[#0B132B] mb-3 uppercase tracking-wider">
          Nota
        </h3>
        <p className="text-sm text-[#6B7280] leading-relaxed">
          Los cálculos de finanzas (material, luz, ganancia, margen, variación,
          costo de fallas) residen exclusivamente en el backend (§3.8). Esta app
          solo presenta lo que devuelve la API.
        </p>
      </div>
    </div>
  );
}
