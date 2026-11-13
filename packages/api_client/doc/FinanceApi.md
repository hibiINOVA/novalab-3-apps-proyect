# novalab_api.api.FinanceApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createExpense**](FinanceApi.md#createexpense) | **POST** /api/finance/expenses | Registra un gasto (F-09)
[**deleteExpense**](FinanceApi.md#deleteexpense) | **DELETE** /api/finance/expenses/{expenseId} | Elimina un gasto (F-09)
[**financeFailures**](FinanceApi.md#financefailures) | **GET** /api/finance/failures | Costo de fallas del mes (gramos y dinero perdidos, F-08)
[**financeGoal**](FinanceApi.md#financegoal) | **GET** /api/finance/goal | Meta de ganancia del mes y tarifa de luz vigentes (F-10)
[**financeProducts**](FinanceApi.md#financeproducts) | **GET** /api/finance/products | Rentabilidad por producto, histórico de la organización (F-07)
[**financeSummary**](FinanceApi.md#financesummary) | **GET** /api/finance/summary | Resumen financiero del mes (ingresos, costos, ganancia y meta, F-04)
[**financeTrend**](FinanceApi.md#financetrend) | **GET** /api/finance/trend | Ingresos, costos y ganancia de los últimos 12 meses (F-06)
[**listExpenses**](FinanceApi.md#listexpenses) | **GET** /api/finance/expenses | Gastos del negocio (F-09)
[**listFinanceOrders**](FinanceApi.md#listfinanceorders) | **GET** /api/finance/orders | Pedidos con desglose de costos y ganancia (F-05)
[**updateExpense**](FinanceApi.md#updateexpense) | **PATCH** /api/finance/expenses/{expenseId} | Actualiza un gasto (F-09)
[**updateFinanceGoal**](FinanceApi.md#updatefinancegoal) | **PATCH** /api/finance/goal | Actualiza la meta del mes y/o la tarifa de luz (F-10)


# **createExpense**
> Expense createExpense(expenseCreateRequest)

Registra un gasto (F-09)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final ExpenseCreateRequest expenseCreateRequest = ; // ExpenseCreateRequest | 

try {
    final response = api.createExpense(expenseCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->createExpense: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **expenseCreateRequest** | [**ExpenseCreateRequest**](ExpenseCreateRequest.md)|  | 

### Return type

[**Expense**](Expense.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteExpense**
> deleteExpense(expenseId)

Elimina un gasto (F-09)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final int expenseId = 789; // int | 

try {
    api.deleteExpense(expenseId);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->deleteExpense: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **expenseId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeFailures**
> BuiltList<FinanceFailure> financeFailures(month)

Costo de fallas del mes (gramos y dinero perdidos, F-08)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 

try {
    final response = api.financeFailures(month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->financeFailures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 

### Return type

[**BuiltList&lt;FinanceFailure&gt;**](FinanceFailure.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeGoal**
> MonthlyGoal financeGoal(month)

Meta de ganancia del mes y tarifa de luz vigentes (F-10)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 

try {
    final response = api.financeGoal(month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->financeGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 

### Return type

[**MonthlyGoal**](MonthlyGoal.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeProducts**
> BuiltList<FinanceProduct> financeProducts()

Rentabilidad por producto, histórico de la organización (F-07)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();

try {
    final response = api.financeProducts();
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->financeProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;FinanceProduct&gt;**](FinanceProduct.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeSummary**
> FinanceSummary financeSummary(month)

Resumen financiero del mes (ingresos, costos, ganancia y meta, F-04)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 

try {
    final response = api.financeSummary(month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->financeSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 

### Return type

[**FinanceSummary**](FinanceSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeTrend**
> BuiltList<FinanceTrendPoint> financeTrend()

Ingresos, costos y ganancia de los últimos 12 meses (F-06)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();

try {
    final response = api.financeTrend();
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->financeTrend: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;FinanceTrendPoint&gt;**](FinanceTrendPoint.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listExpenses**
> BuiltList<Expense> listExpenses(month)

Gastos del negocio (F-09)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 

try {
    final response = api.listExpenses(month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->listExpenses: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;Expense&gt;**](Expense.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listFinanceOrders**
> BuiltList<FinanceOrder> listFinanceOrders(month, status, q)

Pedidos con desglose de costos y ganancia (F-05)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 
final String status = status_example; // String | 
final String q = q_example; // String | Búsqueda por folio o nombre de cliente

try {
    final response = api.listFinanceOrders(month, status, q);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->listFinanceOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 
 **q** | **String**| Búsqueda por folio o nombre de cliente | [optional] 

### Return type

[**BuiltList&lt;FinanceOrder&gt;**](FinanceOrder.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExpense**
> Expense updateExpense(expenseId, expenseUpdateRequest)

Actualiza un gasto (F-09)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final int expenseId = 789; // int | 
final ExpenseUpdateRequest expenseUpdateRequest = ; // ExpenseUpdateRequest | 

try {
    final response = api.updateExpense(expenseId, expenseUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->updateExpense: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **expenseId** | **int**|  | 
 **expenseUpdateRequest** | [**ExpenseUpdateRequest**](ExpenseUpdateRequest.md)|  | 

### Return type

[**Expense**](Expense.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateFinanceGoal**
> MonthlyGoal updateFinanceGoal(month, monthlyGoalUpdate)

Actualiza la meta del mes y/o la tarifa de luz (F-10)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getFinanceApi();
final String month = month_example; // String | 
final MonthlyGoalUpdate monthlyGoalUpdate = ; // MonthlyGoalUpdate | 

try {
    final response = api.updateFinanceGoal(month, monthlyGoalUpdate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->updateFinanceGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 
 **monthlyGoalUpdate** | [**MonthlyGoalUpdate**](MonthlyGoalUpdate.md)|  | 

### Return type

[**MonthlyGoal**](MonthlyGoal.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

