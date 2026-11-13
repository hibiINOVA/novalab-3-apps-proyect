import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for FinanceApi
void main() {
  final instance = NovalabApi().getFinanceApi();

  group(FinanceApi, () {
    // Registra un gasto (F-09)
    //
    //Future<Expense> createExpense(ExpenseCreateRequest expenseCreateRequest) async
    test('test createExpense', () async {
      // TODO
    });

    // Elimina un gasto (F-09)
    //
    //Future deleteExpense(int expenseId) async
    test('test deleteExpense', () async {
      // TODO
    });

    // Costo de fallas del mes (gramos y dinero perdidos, F-08)
    //
    //Future<BuiltList<FinanceFailure>> financeFailures(String month) async
    test('test financeFailures', () async {
      // TODO
    });

    // Meta de ganancia del mes y tarifa de luz vigentes (F-10)
    //
    //Future<MonthlyGoal> financeGoal(String month) async
    test('test financeGoal', () async {
      // TODO
    });

    // Rentabilidad por producto, histórico de la organización (F-07)
    //
    //Future<BuiltList<FinanceProduct>> financeProducts() async
    test('test financeProducts', () async {
      // TODO
    });

    // Resumen financiero del mes (ingresos, costos, ganancia y meta, F-04)
    //
    //Future<FinanceSummary> financeSummary(String month) async
    test('test financeSummary', () async {
      // TODO
    });

    // Ingresos, costos y ganancia de los últimos 12 meses (F-06)
    //
    //Future<BuiltList<FinanceTrendPoint>> financeTrend() async
    test('test financeTrend', () async {
      // TODO
    });

    // Gastos del negocio (F-09)
    //
    //Future<BuiltList<Expense>> listExpenses({ String month }) async
    test('test listExpenses', () async {
      // TODO
    });

    // Pedidos con desglose de costos y ganancia (F-05)
    //
    //Future<BuiltList<FinanceOrder>> listFinanceOrders({ String month, String status, String q }) async
    test('test listFinanceOrders', () async {
      // TODO
    });

    // Actualiza un gasto (F-09)
    //
    //Future<Expense> updateExpense(int expenseId, ExpenseUpdateRequest expenseUpdateRequest) async
    test('test updateExpense', () async {
      // TODO
    });

    // Actualiza la meta del mes y/o la tarifa de luz (F-10)
    //
    //Future<MonthlyGoal> updateFinanceGoal(String month, MonthlyGoalUpdate monthlyGoalUpdate) async
    test('test updateFinanceGoal', () async {
      // TODO
    });
  });
}
