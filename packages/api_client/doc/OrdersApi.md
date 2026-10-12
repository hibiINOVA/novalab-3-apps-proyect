# novalab_api.api.OrdersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOrder**](OrdersApi.md#createorder) | **POST** /api/orders | Crea un pedido nuevo (P-09)
[**getOrder**](OrdersApi.md#getorder) | **GET** /api/orders/{orderId} | Detalle de pedido (items, faltantes, historial, envío)
[**listOrders**](OrdersApi.md#listorders) | **GET** /api/orders | Lista pedidos con filtros y búsqueda por folio/cliente
[**updateOrderStatus**](OrdersApi.md#updateorderstatus) | **PATCH** /api/orders/{orderId}/status | Cambio manual de estado (Empacado, Enviado, Entregado, Cancelado)


# **createOrder**
> OrderDetail createOrder(orderCreateRequest)

Crea un pedido nuevo (P-09)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrdersApi();
final OrderCreateRequest orderCreateRequest = ; // OrderCreateRequest | 

try {
    final response = api.createOrder(orderCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrdersApi->createOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderCreateRequest** | [**OrderCreateRequest**](OrderCreateRequest.md)|  | 

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrder**
> OrderDetail getOrder(orderId)

Detalle de pedido (items, faltantes, historial, envío)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrdersApi();
final int orderId = 789; // int | 

try {
    final response = api.getOrder(orderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrdersApi->getOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **int**|  | 

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listOrders**
> BuiltList<OrderSummary> listOrders(status, customerId, dueBefore, q)

Lista pedidos con filtros y búsqueda por folio/cliente

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrdersApi();
final OrderStatus status = ; // OrderStatus | 
final int customerId = 789; // int | 
final Date dueBefore = 2013-10-20; // Date | 
final String q = q_example; // String | Búsqueda por folio o nombre de cliente

try {
    final response = api.listOrders(status, customerId, dueBefore, q);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrdersApi->listOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | [**OrderStatus**](.md)|  | [optional] 
 **customerId** | **int**|  | [optional] 
 **dueBefore** | **Date**|  | [optional] 
 **q** | **String**| Búsqueda por folio o nombre de cliente | [optional] 

### Return type

[**BuiltList&lt;OrderSummary&gt;**](OrderSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOrderStatus**
> OrderDetail updateOrderStatus(orderId, orderStatusUpdateRequest)

Cambio manual de estado (Empacado, Enviado, Entregado, Cancelado)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrdersApi();
final int orderId = 789; // int | 
final OrderStatusUpdateRequest orderStatusUpdateRequest = ; // OrderStatusUpdateRequest | 

try {
    final response = api.updateOrderStatus(orderId, orderStatusUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrdersApi->updateOrderStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **int**|  | 
 **orderStatusUpdateRequest** | [**OrderStatusUpdateRequest**](OrderStatusUpdateRequest.md)|  | 

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

