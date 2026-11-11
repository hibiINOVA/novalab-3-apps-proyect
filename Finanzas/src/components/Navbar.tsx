import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "$lib/auth";

interface NavbarProps {
  user: { name?: string | null; email?: string } | null;
  onLogout: () => void;
}

export function Navbar({ user, onLogout }: NavbarProps) {
  const navigate = useNavigate();
  const { isOwner: isOwnerRole } = useAuth();

  const items = [
    { to: "/", label: "Resumen" },
    { to: "/orders", label: "Pedidos" },
    { to: "/trend", label: "Tendencia" },
    { to: "/products", label: "Productos" },
    { to: "/failures", label: "Fallas" },
    { to: "/expenses", label: "Gastos" },
    { to: "/settings", label: "Ajustes" },
  ];

  return (
    <header className="bg-[#0B132B] text-white shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center gap-3">
            <span className="text-xl font-bold tracking-tight">NOVALAB</span>
            <span className="text-xs text-[#00FF87] font-bold tracking-wider uppercase">
              finanzas
            </span>
          </div>
          <nav className="hidden md:flex items-center gap-6 text-sm font-medium">
            {items.map((item) => (
              <Link
                key={item.to}
                to={item.to}
                className={`px-3 py-2 rounded-md transition ${
                  window.location.pathname === item.to
                    ? "bg-[#00FF87] text-[#0B132B]"
                    : "text-gray-300 hover:text-white hover:bg-white/10"
                }`}
              >
                {item.label}
              </Link>
            ))}
          </nav>
          <div className="flex items-center gap-3">
            <span className="text-sm text-gray-300 hidden sm:block">
              {user?.name ?? user?.email ?? "Usuario"}
              {isOwnerRole ? "  ·  dueño" : ""}
            </span>
            <button
              onClick={() => {
                onLogout();
                navigate("/login");
              }}
              className="text-sm text-[#00FF87] underline hover:text-[#00FF87]/80"
            >
              Cerrar sesión
            </button>
          </div>
        </div>
      </div>
    </header>
  );
}
