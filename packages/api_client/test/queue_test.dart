import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

// tests for Queue
void main() {
  final instance = QueueBuilder();
  // TODO add properties to the builder and call build()

  group(Queue, () {
    // BuiltList<QueueItem> unassigned
    test('to test the property `unassigned`', () async {
      // TODO
    });

    // Mapa printer_id (string) -> items asignados
    // BuiltMap<String, BuiltList<QueueItem>> byPrinter
    test('to test the property `byPrinter`', () async {
      // TODO
    });

    // Versión para control de concurrencia optimista
    // int version
    test('to test the property `version`', () async {
      // TODO
    });
  });
}
