import { useMemo } from "react";
import { useProducts } from "$lib/hooks";
import { formatPercent } from "$lib/format";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  Badge,
  Money,
} from "$components/ui";

export function Products() {
  const { data: products = [], isLoading } = useProducts();

  if (isLoading)
    return <div className="p-6 text-[#6B7280]">Cargando productos…</div>;

  const sorted = useMemo(
    () => [...products].sort((a, b) => b.margin - a.margin),
    [products],
  );

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#0B132B]">
          Rentabilidad por producto
        </h1>
        <p className="text-[#6B7280]">Cuáles dejan más y menos margen (F-07)</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{sorted.length} producto(s)</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead>
                <tr className="border-b border-[#E5E7EB]">
                  <th className="pb-3 text-[#6B7280] font-semibold">
                    Producto
                  </th>
                  <th className="pb-3 text-[#6B7280] font-semibold text-right">
                    Pedidos
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
                </tr>
              </thead>
              <tbody className="divide-y divide-[#E5E7EB]">
                {sorted.map((p) => (
                  <tr key={p.product_id} className="hover:bg-[#F9FAFB]">
                    <td className="py-3 font-medium">{p.product_name}</td>
                    <td className="py-3 tabular-nums text-right">
                      {p.orders_count}
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={p.income} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      <Money value={p.costs} />
                    </td>
                    <td className="py-3 tabular-nums text-right font-medium">
                      <Money value={p.profit} />
                    </td>
                    <td className="py-3 tabular-nums text-right">
                      <Badge variant={p.margin >= 0 ? "success" : "danger"}>
                        {formatPercent(p.margin)}
                      </Badge>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {sorted.length === 0 && (
            <div className="p-6 text-center text-[#6B7280]">
              No hay datos de productos.
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
