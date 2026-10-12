# novalab_api.api.QueueApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**acceptQueueAssignment**](QueueApi.md#acceptqueueassignment) | **POST** /api/queue/accept | Acepta (total o parcialmente) una propuesta de asignación
[**getQueue**](QueueApi.md#getqueue) | **GET** /api/queue | Cola de producción (items sin asignar y por impresora)
[**reorderQueue**](QueueApi.md#reorderqueue) | **PATCH** /api/queue/reorder | Mueve y reordena items entre impresoras y la cola sin asignar
[**suggestQueueAssignment**](QueueApi.md#suggestqueueassignment) | **POST** /api/queue/suggest | Propone una asignación de la cola (BE-13, BE-14)


# **acceptQueueAssignment**
> Queue acceptQueueAssignment(queueAcceptRequest)

Acepta (total o parcialmente) una propuesta de asignación

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getQueueApi();
final QueueAcceptRequest queueAcceptRequest = ; // QueueAcceptRequest | 

try {
    final response = api.acceptQueueAssignment(queueAcceptRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling QueueApi->acceptQueueAssignment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queueAcceptRequest** | [**QueueAcceptRequest**](QueueAcceptRequest.md)|  | 

### Return type

[**Queue**](Queue.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getQueue**
> Queue getQueue()

Cola de producción (items sin asignar y por impresora)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getQueueApi();

try {
    final response = api.getQueue();
    print(response);
} catch on DioException (e) {
    print('Exception when calling QueueApi->getQueue: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Queue**](Queue.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reorderQueue**
> Queue reorderQueue(queueReorderRequest)

Mueve y reordena items entre impresoras y la cola sin asignar

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getQueueApi();
final QueueReorderRequest queueReorderRequest = ; // QueueReorderRequest | 

try {
    final response = api.reorderQueue(queueReorderRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling QueueApi->reorderQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queueReorderRequest** | [**QueueReorderRequest**](QueueReorderRequest.md)|  | 

### Return type

[**Queue**](Queue.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **suggestQueueAssignment**
> QueueSuggestion suggestQueueAssignment()

Propone una asignación de la cola (BE-13, BE-14)

El backend propone a qué impresora va cada item pendiente, con una explicación legible. El operador decide aceptar todo, aceptar parcial o descartar.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getQueueApi();

try {
    final response = api.suggestQueueAssignment();
    print(response);
} catch on DioException (e) {
    print('Exception when calling QueueApi->suggestQueueAssignment: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**QueueSuggestion**](QueueSuggestion.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

