# novalab_api.model.Queue

## Load the model package
```dart
import 'package:novalab_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**unassigned** | [**BuiltList&lt;QueueItem&gt;**](QueueItem.md) |  | 
**byPrinter** | [**BuiltMap&lt;String, BuiltList&lt;QueueItem&gt;&gt;**](BuiltList.md) | Mapa printer_id (string) -> items asignados | 
**version** | **int** | Versión para control de concurrencia optimista | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


