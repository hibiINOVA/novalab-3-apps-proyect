import { describe, expect, it } from "vitest";
import {
  formatCurrency,
  formatNumber,
  formatPercent,
  monthLabel,
} from "./format";

describe("formatCurrency", () => {
  it("formatea pesos mexicanos con 2 decimales", () => {
    expect(formatCurrency(1234.5)).toBe("$1,234.50");
  });

  it("respeta la moneda indicada", () => {
    expect(formatCurrency(10, "USD", "en-US")).toBe("$10.00");
  });
});

describe("formatNumber", () => {
  it("muestra 2 decimales por defecto", () => {
    expect(formatNumber(5)).toBe("5.00");
  });

  it("respeta los decimales indicados", () => {
    expect(formatNumber(3.1416, 3)).toBe("3.142");
  });
});

describe("formatPercent", () => {
  it("prefija '+' a los valores positivos", () => {
    expect(formatPercent(0.125)).toBe("+12.5%");
  });

  it("los negativos conservan su signo", () => {
    expect(formatPercent(-0.2)).toBe("-20.0%");
  });
});

describe("monthLabel", () => {
  it("convierte YYYY-MM a mes legible en es-MX", () => {
    expect(monthLabel("2026-01")).toBe("ene 2026");
    expect(monthLabel("2026-12")).toBe("dic 2026");
  });
});
