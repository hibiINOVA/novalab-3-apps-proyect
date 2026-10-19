# novalab_api.api.PrintersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPrinter**](PrintersApi.md#createprinter) | **POST** /api/printers | Registra una nueva impresora en el taller
[**deletePrinter**](PrintersApi.md#deleteprinter) | **DELETE** /api/printers/{printerId} | Elimina una impresora del taller
[**getPrinter**](PrintersApi.md#getprinter) | **GET** /api/printers/{printerId} | Detalle de una impresora
[**getPrinterCameraSnapshot**](PrintersApi.md#getprintercamerasnapshot) | **GET** /api/printers/{printerId}/camera/snapshot | Última miniatura de cámara de la impresora (servida por el backend)
[**listPrinters**](PrintersApi.md#listprinters) | **GET** /api/printers | Lista las impresoras con su estado en vivo
[**testPrinterConnection**](PrintersApi.md#testprinterconnection) | **POST** /api/printers/test | Prueba la conexión a OctoPrint con URL y API key (BE-01)
[**testPrinterConnectionById**](PrintersApi.md#testprinterconnectionbyid) | **POST** /api/printers/{printerId}/test | Prueba la conexión guardada de una impresora (BE-01)
[**updatePrinter**](PrintersApi.md#updateprinter) | **PATCH** /api/printers/{printerId} | Actualiza configuración o estado de la impresora


# **createPrinter**
> Printer createPrinter(printerCreateRequest)

Registra una nueva impresora en el taller

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final PrinterCreateRequest printerCreateRequest = ; // PrinterCreateRequest | 

try {
    final response = api.createPrinter(printerCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->createPrinter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerCreateRequest** | [**PrinterCreateRequest**](PrinterCreateRequest.md)|  | 

### Return type

[**Printer**](Printer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePrinter**
> deletePrinter(printerId)

Elimina una impresora del taller

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 

try {
    api.deletePrinter(printerId);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->deletePrinter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPrinter**
> Printer getPrinter(printerId)

Detalle de una impresora

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 

try {
    final response = api.getPrinter(printerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->getPrinter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 

### Return type

[**Printer**](Printer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPrinterCameraSnapshot**
> Uint8List getPrinterCameraSnapshot(printerId, index)

Última miniatura de cámara de la impresora (servida por el backend)

Devuelve la última instantánea guardada por el backend (BE-07/08). El cliente nunca accede al stream ni a la IP de la impresora. `index` selecciona la cámara (0 = principal).

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 
final int index = 56; // int | Índice de cámara (0 = principal).

try {
    final response = api.getPrinterCameraSnapshot(printerId, index);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->getPrinterCameraSnapshot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 
 **index** | **int**| Índice de cámara (0 = principal). | [optional] [default to 0]

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

# **testPrinterConnection**
> PrinterConnectionTest testPrinterConnection(printerConnectionTestRequest)

Prueba la conexión a OctoPrint con URL y API key (BE-01)

Valida URL + API key contra `/api/version` de OctoPrint antes de dar de alta la impresora. No guarda nada.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final PrinterConnectionTestRequest printerConnectionTestRequest = ; // PrinterConnectionTestRequest | 

try {
    final response = api.testPrinterConnection(printerConnectionTestRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->testPrinterConnection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerConnectionTestRequest** | [**PrinterConnectionTestRequest**](PrinterConnectionTestRequest.md)|  | 

### Return type

[**PrinterConnectionTest**](PrinterConnectionTest.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **testPrinterConnectionById**
> PrinterConnectionTest testPrinterConnectionById(printerId)

Prueba la conexión guardada de una impresora (BE-01)

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 

try {
    final response = api.testPrinterConnectionById(printerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->testPrinterConnectionById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 

### Return type

[**PrinterConnectionTest**](PrinterConnectionTest.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePrinter**
> Printer updatePrinter(printerId, printerUpdateRequest)

Actualiza configuración o estado de la impresora

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintersApi();
final int printerId = 789; // int | 
final PrinterUpdateRequest printerUpdateRequest = ; // PrinterUpdateRequest | 

try {
    final response = api.updatePrinter(printerId, printerUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintersApi->updatePrinter: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printerId** | **int**|  | 
 **printerUpdateRequest** | [**PrinterUpdateRequest**](PrinterUpdateRequest.md)|  | 

### Return type

[**Printer**](Printer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

