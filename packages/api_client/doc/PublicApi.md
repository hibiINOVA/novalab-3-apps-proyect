# novalab_api.api.PublicApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getBranding**](PublicApi.md#getbranding) | **GET** /api/public/branding | Marca y configuración visible del negocio


# **getBranding**
> Branding getBranding()

Marca y configuración visible del negocio

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPublicApi();

try {
    final response = api.getBranding();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicApi->getBranding: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Branding**](Branding.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

