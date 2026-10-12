import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for CustomersApi
void main() {
  final instance = NovalabApi().getCustomersApi();

  group(CustomersApi, () {
    // Lista de clientes (para nuevo pedido)
    //
    //Future<BuiltList<Customer>> listCustomers() async
    test('test listCustomers', () async {
      // TODO
    });
  });
}
