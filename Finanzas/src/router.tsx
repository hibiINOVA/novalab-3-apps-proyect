import { createBrowserRouter } from "react-router-dom";
import { Layout } from "./components/Layout";
import { Login } from "./pages/Login";
import { Dashboard } from "./pages/Dashboard";
import { Orders } from "./pages/Orders";
import { Trend } from "./pages/Trend";
import { Products } from "./pages/Products";
import { Failures } from "./pages/Failures";
import { Expenses } from "./pages/Expenses";
import { Settings } from "./pages/Settings";
import { requireOwner } from "./lib/auth";

const router = createBrowserRouter(
  [
    {
      path: "/",
      Component: Layout,
      children: [
        { index: true, Component: requireOwner(Dashboard) },
        { path: "orders", Component: requireOwner(Orders) },
        { path: "trend", Component: requireOwner(Trend) },
        { path: "products", Component: requireOwner(Products) },
        { path: "failures", Component: requireOwner(Failures) },
        { path: "expenses", Component: requireOwner(Expenses) },
        { path: "settings", Component: requireOwner(Settings) },
      ],
    },
    { path: "/login", Component: Login },
  ],
  { basename: "/finanzas" },
);

export default router;
