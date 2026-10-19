# novalab_api.api.PrintJobsApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**completePrintJob**](PrintJobsApi.md#completeprintjob) | **POST** /api/print-jobs/{jobId}/complete | Marca un job como terminado
[**downloadPrintJobGcode**](PrintJobsApi.md#downloadprintjobgcode) | **GET** /api/print-jobs/{jobId}/gcode | Descarga el archivo G-code asociado a un job
[**failPrintJob**](PrintJobsApi.md#failprintjob) | **POST** /api/print-jobs/{jobId}/fail | Marca un job como fallido y registra el motivo
[**reprintJob**](PrintJobsApi.md#reprintjob) | **POST** /api/print-jobs/{jobId}/reprint | Crea un nuevo job para reimprimir un item fallido
[**startPrintJob**](PrintJobsApi.md#startprintjob) | **POST** /api/print-jobs | Confirma e inicia la impresión de un item (BE-05)
[**uploadPrintJobGcode**](PrintJobsApi.md#uploadprintjobgcode) | **POST** /api/print-jobs/{jobId}/gcode | Sube el archivo G-code asociado a un job (BE-05)


# **completePrintJob**
> PrintJob completePrintJob(jobId)

Marca un job como terminado

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final int jobId = 789; // int | 

try {
    final response = api.completePrintJob(jobId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->completePrintJob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **int**|  | 

### Return type

[**PrintJob**](PrintJob.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **downloadPrintJobGcode**
> Uint8List downloadPrintJobGcode(jobId)

Descarga el archivo G-code asociado a un job

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final int jobId = 789; // int | 

try {
    final response = api.downloadPrintJobGcode(jobId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->downloadPrintJobGcode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **int**|  | 

### Return type

[**Uint8List**](Uint8List.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **failPrintJob**
> PrintJob failPrintJob(jobId, printJobFailRequest)

Marca un job como fallido y registra el motivo

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final int jobId = 789; // int | 
final PrintJobFailRequest printJobFailRequest = ; // PrintJobFailRequest | 

try {
    final response = api.failPrintJob(jobId, printJobFailRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->failPrintJob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **int**|  | 
 **printJobFailRequest** | [**PrintJobFailRequest**](PrintJobFailRequest.md)|  | 

### Return type

[**PrintJob**](PrintJob.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reprintJob**
> PrintJob reprintJob(jobId)

Crea un nuevo job para reimprimir un item fallido

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final int jobId = 789; // int | 

try {
    final response = api.reprintJob(jobId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->reprintJob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **int**|  | 

### Return type

[**PrintJob**](PrintJob.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startPrintJob**
> PrintJob startPrintJob(printJobStartRequest)

Confirma e inicia la impresión de un item (BE-05)

Requiere confirmación explícita del operador (\"cama libre y filamento correcto\"). Nunca inicia impresiones de forma automática.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final PrintJobStartRequest printJobStartRequest = ; // PrintJobStartRequest | 

try {
    final response = api.startPrintJob(printJobStartRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->startPrintJob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printJobStartRequest** | [**PrintJobStartRequest**](PrintJobStartRequest.md)|  | 

### Return type

[**PrintJob**](PrintJob.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadPrintJobGcode**
> PrintJob uploadPrintJobGcode(jobId, file)

Sube el archivo G-code asociado a un job (BE-05)

Guarda el archivo .gcode/.gco/.g del job en el servidor (máx. 50 MB). Si la impresora tiene OctoPrint configurado, el backend lo envía e inicia físicamente (BE-05/BE-06; solo tras la confirmación explícita del operador en el start del job). Si el envío falla responde 502 y el job queda en `failed`.

### Example
```dart
import 'package:novalab_api/api.dart';

final api = NovalabApi().getPrintJobsApi();
final int jobId = 789; // int | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.uploadPrintJobGcode(jobId, file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PrintJobsApi->uploadPrintJobGcode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **int**|  | 
 **file** | **MultipartFile**|  | 

### Return type

[**PrintJob**](PrintJob.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

