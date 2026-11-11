import { Outlet } from "react-router-dom";
import { useAuth } from "$lib/auth";
import { Navbar } from "$components/Navbar";

export function Layout() {
  const { logout, user } = useAuth();

  return (
    <div className="flex h-screen flex-col bg-[#f3f4f6]">
      <Navbar user={user} onLogout={logout} />
      <div className="flex-1 overflow-x-hidden overflow-y-auto bg-[#f3f4f6]">
        <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
