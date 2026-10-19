# novalab_api.model.Printer

## Load the model package
```dart
import 'package:novalab_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**name** | **String** |  | 
**state** | [**PrinterState**](PrinterState.md) |  | 
**model** | **String** |  | [optional] 
**progress** | **double** |  | [optional] 
**remainingSeconds** | **int** |  | [optional] 
**nozzleTemp** | **double** |  | [optional] 
**nozzleTarget** | **double** |  | [optional] 
**bedTemp** | **double** |  | [optional] 
**bedTarget** | **double** |  | [optional] 
**currentFile** | **String** |  | [optional] 
**cameraAvailable** | **bool** |  | [optional] [default to false]
**cameras** | **BuiltList&lt;String&gt;** | URLs de snapshot por cámara (solo admin; BE-08/BE-21). | [optional] 
**loadedSpool** | [**SpoolRef**](SpoolRef.md) |  | [optional] 
**currentOrder** | [**OrderRef**](OrderRef.md) |  | [optional] 
**lastSeen** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


