import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for ProductsApi
void main() {
  final instance = NovalabApi().getProductsApi();

  group(ProductsApi, () {
    // Catálogo de productos (para nuevo pedido)
    //
    //Future<BuiltList<Product>> listProducts() async
    test('test listProducts', () async {
      // TODO
    });
  });
}
