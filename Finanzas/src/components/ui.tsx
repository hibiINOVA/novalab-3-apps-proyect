import { formatCurrency } from "$lib/format";

export function Card({
  className,
  children,
}: {
  className?: string;
  children: React.ReactNode;
}) {
  return (
    <div
      className={`bg-white border border-[#E5E7EB] rounded-xl shadow-sm ${className ?? ""}`}
    >
      {children}
    </div>
  );
}

export function CardHeader({ children }: { children: React.ReactNode }) {
  return <div className="border-b border-[#E5E7EB] pb-4 px-6">{children}</div>;
}

export function CardTitle({ children }: { children: React.ReactNode }) {
  return <h3 className="text-lg font-semibold text-[#0B132B]">{children}</h3>;
}

export function CardContent({
  className,
  children,
}: {
  className?: string;
  children: React.ReactNode;
}) {
  return <div className={`p-6 ${className ?? ""}`}>{children}</div>;
}

export function Badge({
  children,
  variant = "default",
}: {
  children: React.ReactNode;
  variant?: "default" | "success" | "warning" | "danger" | "muted";
}) {
  const base =
    "inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-md text-xs font-semibold";
  const styles: Record<string, string> = {
    default: "bg-[#0B132B] text-white",
    success: "bg-[#00FF87] text-[#0B132B]",
    warning: "bg-[#F59E0B] text-white",
    danger: "bg-[#EF4444] text-white",
    muted: "bg-[#E5E7EB] text-[#6B7280]",
  };
  return <span className={`${base} ${styles[variant]}`}>{children}</span>;
}

export function Money({
  value,
  currency = "MXN",
  className,
}: {
  value: number;
  currency?: string;
  className?: string;
}) {
  return (
    <span className={`tabular-nums font-medium ${className ?? ""}`}>
      {formatCurrency(value, currency)}
    </span>
  );
}
