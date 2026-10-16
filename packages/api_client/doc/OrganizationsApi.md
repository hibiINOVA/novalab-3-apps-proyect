# novalab_api.api.OrganizationsApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approveOrganizationRequest**](OrganizationsApi.md#approveorganizationrequest) | **POST** /api/organizations/requests/{requestId}/approve | Dueño acepta la solicitud de un operador
[**createOrganization**](OrganizationsApi.md#createorganization) | **POST** /api/organizations | Crea una organización nueva (Dueño) y genera su ID único
[**getCurrentOrganization**](OrganizationsApi.md#getcurrentorganization) | **GET** /api/organizations/current | Obtiene el estado actual de la organización y membresía del usuario
[**joinOrganization**](OrganizationsApi.md#joinorganization) | **POST** /api/organizations/join | Operador solicita unirse a una organización usando su ID
[**listOrganizationRequests**](OrganizationsApi.md#listorganizationrequests) | **GET** /api/organizations/requests | Lista de solicitudes pendientes de operadores (Dueño)
[**rejectOrganizationRequest**](OrganizationsApi.md#rejectorganizationrequest) | **POST** /api/organizations/requests/{requestId}/reject | Dueño rechaza la solicitud de un operador


# **approveOrganizationRequest**
> OrganizationMember approveOrganizationRequest(requestId)

Dueño acepta la solicitud de un operador

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();
final int requestId = 789; // int | 

try {
    final response = api.approveOrganizationRequest(requestId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->approveOrganizationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **int**|  | 

### Return type

[**OrganizationMember**](OrganizationMember.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOrganization**
> Organization createOrganization(organizationCreateRequest)

Crea una organización nueva (Dueño) y genera su ID único

Crea una organización asociada al usuario autenticado (debe ser Dueño). Devuelve el código único generado (p. ej. ORG-NOVA-8492) para compartir con operadores.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();
final OrganizationCreateRequest organizationCreateRequest = ; // OrganizationCreateRequest | 

try {
    final response = api.createOrganization(organizationCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->createOrganization: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **organizationCreateRequest** | [**OrganizationCreateRequest**](OrganizationCreateRequest.md)|  | 

### Return type

[**Organization**](Organization.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCurrentOrganization**
> UserOrganizationStatus getCurrentOrganization()

Obtiene el estado actual de la organización y membresía del usuario

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();

try {
    final response = api.getCurrentOrganization();
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->getCurrentOrganization: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserOrganizationStatus**](UserOrganizationStatus.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **joinOrganization**
> UserOrganizationStatus joinOrganization(joinOrganizationRequest)

Operador solicita unirse a una organización usando su ID

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();
final JoinOrganizationRequest joinOrganizationRequest = ; // JoinOrganizationRequest | 

try {
    final response = api.joinOrganization(joinOrganizationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->joinOrganization: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **joinOrganizationRequest** | [**JoinOrganizationRequest**](JoinOrganizationRequest.md)|  | 

### Return type

[**UserOrganizationStatus**](UserOrganizationStatus.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listOrganizationRequests**
> BuiltList<OrganizationMember> listOrganizationRequests()

Lista de solicitudes pendientes de operadores (Dueño)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();

try {
    final response = api.listOrganizationRequests();
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->listOrganizationRequests: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;OrganizationMember&gt;**](OrganizationMember.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectOrganizationRequest**
> OrganizationMember rejectOrganizationRequest(requestId)

Dueño rechaza la solicitud de un operador

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getOrganizationsApi();
final int requestId = 789; // int | 

try {
    final response = api.rejectOrganizationRequest(requestId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrganizationsApi->rejectOrganizationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **int**|  | 

### Return type

[**OrganizationMember**](OrganizationMember.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

