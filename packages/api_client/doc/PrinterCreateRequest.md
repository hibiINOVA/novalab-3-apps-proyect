# novalab_api.model.PrinterCreateRequest

## Load the model package
```dart
import 'package:novalab_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | 
**model** | **String** | Modelo comercial de la impresora (p. ej. Prusa MK4) | [optional] 
**octoprintUrl** | **String** |  | [optional] 
**apiKey** | **String** |  | [optional] 
**bedWidth** | **double** |  | [optional] 
**bedDepth** | **double** |  | [optional] 
**cameraAvailable** | **bool** |  | [optional] [default to false]
**cameras** | **BuiltList&lt;String&gt;** | URLs de snapshot por cámara (BE-07). La primera es la principal. El backend las consume; jamás se exponen al cliente público. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


