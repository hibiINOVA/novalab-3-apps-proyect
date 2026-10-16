"""Fórmulas de finanzas (§3.8). ÚNICO lugar donde viven (invariante BE)."""


def costo_material(grams_used: float, cost_per_kg: float) -> float:
    return grams_used * (cost_per_kg / 1000.0)


def costo_luz(hours: float, printer_kw: float, tariff_kwh: float) -> float:
    return hours * printer_kw * tariff_kwh


def costo_pedido(
    material: float,
    light: float,
    packaging: float,
    shipping: float,
    commissions: float,
    other: float = 0.0,
) -> float:
    return material + light + packaging + shipping + commissions + other


def ganancia_pedido(total: float, cost: float) -> float:
    return total - cost


def margen(ganancia: float, total: float) -> float:
    if total == 0:
        return 0.0
    return ganancia / total


def costo_fallas(
    failed_jobs: list[tuple[float, float, float]],
    printer_kw: float,
    tariff_kwh: float,
) -> float:
    """Costo de jobs Fallido = material + luz (reportado aparte, §3.8).

    `failed_jobs` es una lista de tuplas (grams_real, cost_per_kg, minutes_real).
    """
    total = 0.0
    for grams, cost_per_kg, minutes in failed_jobs:
        total += costo_material(grams, cost_per_kg)
        total += costo_luz(minutes / 60.0, printer_kw, tariff_kwh)
    return total


def variacion_mensual(ganancia_mes: float, ganancia_mes_anterior: float) -> float:
    if ganancia_mes_anterior == 0:
        return 0.0
    return (ganancia_mes - ganancia_mes_anterior) / ganancia_mes_anterior


def faltante_meta(meta_mes: float, ganancia_mes: float) -> float:
    return max(0.0, meta_mes - ganancia_mes)
