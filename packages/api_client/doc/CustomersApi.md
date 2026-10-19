# novalab_api.api.CustomersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCustomer**](CustomersApi.md#createcustomer) | **POST** /api/customers | Registra un nuevo cliente
[**getCustomer**](CustomersApi.md#getcustomer) | **GET** /api/customers/{customerId} | Detalle de un cliente por su ID
[**listCustomers**](CustomersApi.md#listcustomers) | **GET** /api/customers | Lista de clientes (para nuevo pedido)


# **createCustomer**
> Customer createCustomer(customerCreateRequest)

Registra un nuevo cliente

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getCustomersApi();
final CustomerCreateRequest customerCreateRequest = ; // CustomerCreateRequest | 

try {
    final response = api.createCustomer(customerCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CustomersApi->createCustomer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerCreateRequest** | [**CustomerCreateRequest**](CustomerCreateRequest.md)|  | 

### Return type

[**Customer**](Customer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCustomer**
> Customer getCustomer(customerId)

Detalle de un cliente por su ID

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getCustomersApi();
final int customerId = 789; // int | 

try {
    final response = api.getCustomer(customerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CustomersApi->getCustomer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerId** | **int**|  | 

### Return type

[**Customer**](Customer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCustomers**
> BuiltList<Customer> listCustomers()

Lista de clientes (para nuevo pedido)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getCustomersApi();

try {
    final response = api.listCustomers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling CustomersApi->listCustomers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Customer&gt;**](Customer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

