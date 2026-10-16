# novalab_api.api.PublicApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getBranding**](PublicApi.md#getbranding) | **GET** /api/public/branding | Marca y configuración visible del negocio
[**getPublicTrack**](PublicApi.md#getpublictrack) | **GET** /api/public/track/{token} | Seguimiento público de pedido por token
[**getPublicTrackCamera**](PublicApi.md#getpublictrackcamera) | **GET** /api/public/track/{token}/camera | Snapshot de cámara mientras el pedido está imprimiendo (público)
[**lookupOrderToken**](PublicApi.md#lookupordertoken) | **POST** /api/public/lookup | Obtener tracking_token por folio y últimos 4 dígitos del teléfono


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

# **getPublicTrack**
> OrderDetail getPublicTrack(token)

Seguimiento público de pedido por token

Estado, línea de tiempo, items con progreso, envío. No expone costos/ganancias.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPublicApi();
final String token = token_example; // String | 

try {
    final response = api.getPublicTrack(token);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicApi->getPublicTrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPublicTrackCamera**
> Uint8List getPublicTrackCamera(token)

Snapshot de cámara mientras el pedido está imprimiendo (público)

Último snapshot servido por el backend. Solo disponible si aplica.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPublicApi();
final String token = token_example; // String | 

try {
    final response = api.getPublicTrackCamera(token);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicApi->getPublicTrackCamera: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

[**Uint8List**](Uint8List.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/jpeg, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lookupOrderToken**
> PublicLookupResponse lookupOrderToken(publicLookupRequest)

Obtener tracking_token por folio y últimos 4 dígitos del teléfono

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPublicApi();
final PublicLookupRequest publicLookupRequest = ; // PublicLookupRequest | 

try {
    final response = api.lookupOrderToken(publicLookupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PublicApi->lookupOrderToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicLookupRequest** | [**PublicLookupRequest**](PublicLookupRequest.md)|  | 

### Return type

[**PublicLookupResponse**](PublicLookupResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

