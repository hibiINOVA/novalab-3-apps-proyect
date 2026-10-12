# novalab_api.api.ProductsApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listProducts**](ProductsApi.md#listproducts) | **GET** /api/products | Catálogo de productos (para nuevo pedido)


# **listProducts**
> BuiltList<Product> listProducts()

Catálogo de productos (para nuevo pedido)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getProductsApi();

try {
    final response = api.listProducts();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProductsApi->listProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Product&gt;**](Product.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

