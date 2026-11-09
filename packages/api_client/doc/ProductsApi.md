# novalab_api.api.ProductsApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createProduct**](ProductsApi.md#createproduct) | **POST** /api/products | Crear producto en el catálogo de la organización
[**listProducts**](ProductsApi.md#listproducts) | **GET** /api/products | Catálogo de productos (para nuevo pedido)


# **createProduct**
> Product createProduct(productCreateRequest)

Crear producto en el catálogo de la organización

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getProductsApi();
final ProductCreateRequest productCreateRequest = ; // ProductCreateRequest | 

try {
    final response = api.createProduct(productCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProductsApi->createProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productCreateRequest** | [**ProductCreateRequest**](ProductCreateRequest.md)|  | 

### Return type

[**Product**](Product.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

