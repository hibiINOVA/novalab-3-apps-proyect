import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { financeApi } from "$lib/api";
import { useAuth } from "$lib/auth";
import { Card, CardContent, CardHeader, CardTitle } from "$components/ui";

export function Login() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setLoading(true);
    try {
      const res = await financeApi.login({ email, password });
      if (res.user.role !== "owner") {
        setError("Finanzas solo está disponible para el rol dueño.");
        return;
      }
      login(res);
      navigate("/", { replace: true });
    } catch (err: any) {
      setError(
        err?.body?.message ?? "No se pudo iniciar sesión. Inténtalo de nuevo.",
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="w-full max-w-md mx-auto mt-10">
      <CardHeader>
        <CardTitle>Iniciar sesión — Finanzas</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        {error && (
          <div className="rounded-md bg-[#FEF2F2] p-3 text-[#B91C1C] text-sm border border-[#FECACA]">
            {error}
          </div>
        )}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-[#6B7280] mb-1">
              Correo electrónico
            </label>
            <input
              type="email"
              required
              className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-[#00FF87]"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-[#6B7280] mb-1">
              Contraseña
            </label>
            <input
              type="password"
              required
              className="w-full border border-[#D1D5DB] rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-[#00FF87]"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className="w-full bg-[#0B132B] text-white py-2 rounded-md font-semibold disabled:opacity-60 hover:bg-[#0B132B]/90"
          >
            {loading ? "Ingresando…" : "Ingresar"}
          </button>
        </form>
        <p className="text-xs text-[#6B7280] text-center">
          Créditos de demo: <strong>dueno@novalab.mx</strong> /{" "}
          <strong>novalab</strong>
        </p>
      </CardContent>
    </Card>
  );
}
