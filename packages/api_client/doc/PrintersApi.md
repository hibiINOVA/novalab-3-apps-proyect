# novalab_api.api.PrintersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPrinterCameraSnapshot**](PrintersApi.md#getprintercamerasnapshot) | **GET** /api/printers/{printerId}/camera/snapshot | Última miniatura de cámara de la impresora (servida por el backend)
[**listPrinters**](PrintersApi.md#listprinters) | **GET** /api/printers | Lista las impresoras con su estado en vivo


# **getPrinterCameraSnapshot**
> Uint8List getPrinterCameraSnapshot(printerId)

Última miniatura de cámara de la impresora (servida por el backend)

Devuelve la última instantánea guardada por el backend (BE-07/08). El cliente nunca accede al stream ni a la IP de la impresora.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 

try {
    final response = api.getPrinterCameraSnapshot(printerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->getPrinterCameraSnapshot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 

### Return type

[**Uint8List**](Uint8List.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/png, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPrinters**
> BuiltList<Printer> listPrinters()

Lista las impresoras con su estado en vivo

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();

try {
    final response = api.listPrinters();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->listPrinters: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Printer&gt;**](Printer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

