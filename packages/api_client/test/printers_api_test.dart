import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for PrintersApi
void main() {
  final instance = NovalabApi().getPrintersApi();

  group(PrintersApi, () {
    // Lista las impresoras con su estado en vivo
    //
    //Future<BuiltList<Printer>> listPrinters() async
    test('test listPrinters', () async {
      // TODO
    });
  });
}
