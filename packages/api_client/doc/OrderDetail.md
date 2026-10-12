# novalab_api.model.OrderDetail

## Load the model package
```dart
import 'package:novalab_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**folio** | **String** |  | 
**customerName** | **String** |  | 
**status** | [**OrderStatus**](OrderStatus.md) |  | 
**dueState** | [**DueState**](DueState.md) |  | 
**total** | **double** |  | 
**itemsCount** | **int** |  | 
**printedCount** | **int** |  | 
**trackingToken** | **String** |  | 
**items** | [**BuiltList&lt;OrderItem&gt;**](OrderItem.md) |  | 
**history** | [**BuiltList&lt;StatusHistoryEntry&gt;**](StatusHistoryEntry.md) |  | 
**promisedDate** | [**Date**](Date.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**notes** | **String** |  | [optional] 
**customer** | [**Customer**](Customer.md) |  | [optional] 
**shipment** | [**Shipment**](Shipment.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


