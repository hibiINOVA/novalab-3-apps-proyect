# novalab_api.api.CustomersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listCustomers**](CustomersApi.md#listcustomers) | **GET** /api/customers | Lista de clientes (para nuevo pedido)


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

