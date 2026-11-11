import {
  createContext,
  useContext,
  useState,
  useEffect,
  useCallback,
} from "react";
import { useNavigate } from "react-router-dom";
import type { User, LoginResponse } from "$lib/types";

const TOKEN_KEY = "nv_token";
const USER_KEY = "nv_user";

export function setSession(token: string, user: User) {
  if (typeof localStorage === "undefined") return;
  localStorage.setItem(TOKEN_KEY, token);
  localStorage.setItem(USER_KEY, JSON.stringify(user));
}

export function getToken(): string | null {
  if (typeof localStorage === "undefined") return null;
  return localStorage.getItem(TOKEN_KEY);
}

export function getUser(): User | null {
  if (typeof localStorage === "undefined") return null;
  const raw = localStorage.getItem(USER_KEY);
  if (!raw) return null;
  try {
    return JSON.parse(raw) as User;
  } catch {
    return null;
  }
}

export function isOwner(): boolean {
  return getUser()?.role === "owner";
}

export function isAuthenticated(): boolean {
  return !!getToken();
}

export function clearSession() {
  if (typeof localStorage === "undefined") return;
  localStorage.removeItem(TOKEN_KEY);
  localStorage.removeItem(USER_KEY);
}

const AuthContext = createContext<{
  user: User | null;
  isAuthenticated: boolean;
  isOwner: boolean;
  login: (res: LoginResponse) => void;
  logout: () => void;
} | null>(null);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);

  useEffect(() => {
    setUser(getUser());
  }, []);

  const login = useCallback((res: LoginResponse) => {
    setSession(res.access_token, res.user);
    setUser(res.user);
  }, []);

  const logout = useCallback(() => {
    clearSession();
    setUser(null);
  }, []);

  const value = {
    user,
    isAuthenticated: isAuthenticated(),
    isOwner: isOwner(),
    login,
    logout,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth debe usarse dentro de AuthProvider");
  return ctx;
}

export function requireOwner<P extends object>(
  Component: React.ComponentType<P>,
): React.ComponentType<any> {
  function RequireOwner(props: P & { children?: React.ReactNode }) {
    const { isOwner: isOwnerRole, isAuthenticated } = useAuth();
    const navigate = useNavigate();
    if (!isAuthenticated) {
      navigate("/login", { replace: true });
      return null;
    }
    if (!isOwnerRole) {
      return (
        <div className="p-6 text-center">
          Sin permisos: solo el dueño puede acceder a Finanzas.
        </div>
      );
    }
    return <Component {...(props as P)} />;
  }
  RequireOwner.displayName = "RequireOwner";
  return RequireOwner as unknown as React.ComponentType<any>;
}
