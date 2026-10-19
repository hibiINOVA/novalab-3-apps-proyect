# novalab_api.model.PrintJob

## Load the model package
```dart
import 'package:novalab_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**itemId** | **int** |  | 
**printerId** | **int** |  | 
**state** | [**ItemState**](ItemState.md) |  | 
**printerName** | **String** |  | [optional] 
**startedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**finishedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**gramsReal** | **double** |  | [optional] 
**minutesReal** | **int** |  | [optional] 
**failureReason** | **String** |  | [optional] 
**currentFile** | **String** | Nombre del archivo G-code asociado al job (si se subió) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


