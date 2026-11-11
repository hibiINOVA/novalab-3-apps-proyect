import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { financeApi } from "$lib/api";
import type {
  FinanceSummary,
  FinanceOrder,
  ExpenseCreateRequest,
  ExpenseUpdateRequest,
  MonthlyGoalUpdate,
} from "$lib/types";

export function useSummary(month: string) {
  return useQuery({
    queryKey: ["finance", "summary", month],
    queryFn: () => financeApi.getSummary(month),
    enabled: !!month,
  });
}

export function useOrders(params?: {
  month?: string;
  status?: string;
  q?: string;
}) {
  return useQuery({
    queryKey: ["finance", "orders", params],
    queryFn: () => financeApi.getOrders(params),
  });
}

export function useTrend() {
  return useQuery({
    queryKey: ["finance", "trend"],
    queryFn: () => financeApi.getTrend(),
  });
}

export function useProducts() {
  return useQuery({
    queryKey: ["finance", "products"],
    queryFn: () => financeApi.getProducts(),
  });
}

export function useFailures(month: string) {
  return useQuery({
    queryKey: ["finance", "failures", month],
    queryFn: () => financeApi.getFailures(month),
    enabled: !!month,
  });
}

export function useExpenses(month?: string) {
  return useQuery({
    queryKey: ["finance", "expenses", month],
    queryFn: () => financeApi.getExpenses(month),
  });
}

export function useCreateExpense() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: ExpenseCreateRequest) => financeApi.createExpense(body),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["finance", "expenses"] });
      qc.invalidateQueries({ queryKey: ["finance", "summary"] });
    },
  });
}

export function useUpdateExpense() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, body }: { id: number; body: ExpenseUpdateRequest }) =>
      financeApi.updateExpense(id, body),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["finance", "expenses"] });
      qc.invalidateQueries({ queryKey: ["finance", "summary"] });
    },
  });
}

export function useDeleteExpense() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: number) => financeApi.deleteExpense(id),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["finance", "expenses"] });
      qc.invalidateQueries({ queryKey: ["finance", "summary"] });
    },
  });
}

export function useGoal(month: string) {
  return useQuery({
    queryKey: ["finance", "goal", month],
    queryFn: () => financeApi.getGoal(month),
    enabled: !!month,
  });
}

export function useUpdateGoal() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ month, body }: { month: string; body: MonthlyGoalUpdate }) =>
      financeApi.updateGoal(month, body),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["finance", "goal"] });
      qc.invalidateQueries({ queryKey: ["finance", "summary"] });
    },
  });
}

export type { FinanceSummary, FinanceOrder };
