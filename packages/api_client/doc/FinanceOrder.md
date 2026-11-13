# novalab_api.model.FinanceOrder

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
**status** | **String** |  | 
**total** | **num** |  | 
**income** | **num** | Facturado (0 si el pedido está cancelado) | 
**costs** | [**FinanceOrderCostBreakdown**](FinanceOrderCostBreakdown.md) |  | 
**profit** | **num** |  | 
**margin** | **num** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**promisedDate** | [**Date**](Date.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


