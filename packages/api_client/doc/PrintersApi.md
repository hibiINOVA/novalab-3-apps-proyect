# novalab_api.api.PrintersApi

## Load the API package
```dart
import 'package:novalab_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listPrinters**](PrintersApi.md#listprinters) | **GET** /api/printers | Lista las impresoras con su estado en vivo


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

