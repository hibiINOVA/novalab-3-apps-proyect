import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

// tests for StatusEvent
void main() {
  final instance = StatusEventBuilder();
  // TODO add properties to the builder and call build()

  group(StatusEvent, () {
    // Tipo de evento, p. ej. printer.state, queue.updated, order.updated
    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // String entity
    test('to test the property `entity`', () async {
      // TODO
    });

    // int entityId
    test('to test the property `entityId`', () async {
      // TODO
    });

    // DateTime occurredAt
    test('to test the property `occurredAt`', () async {
      // TODO
    });

    // BuiltMap<String, JsonObject> payload
    test('to test the property `payload`', () async {
      // TODO
    });
  });
}
