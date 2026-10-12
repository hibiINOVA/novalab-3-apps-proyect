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
**progress** | **double** |  | [optional] 
**remainingSeconds** | **int** |  | [optional] 
**nozzleTemp** | **double** |  | [optional] 
**nozzleTarget** | **double** |  | [optional] 
**bedTemp** | **double** |  | [optional] 
**bedTarget** | **double** |  | [optional] 
**currentFile** | **String** |  | [optional] 
**cameraAvailable** | **bool** |  | [optional] [default to false]
**loadedSpool** | [**SpoolRef**](SpoolRef.md) |  | [optional] 
**currentOrder** | [**OrderRef**](OrderRef.md) |  | [optional] 
**lastSeen** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


