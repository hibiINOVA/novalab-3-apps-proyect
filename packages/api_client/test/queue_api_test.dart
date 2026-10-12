import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for QueueApi
void main() {
  final instance = NovalabApi().getQueueApi();

  group(QueueApi, () {
    // Cola de producción (items sin asignar y por impresora)
    //
    //Future<Queue> getQueue() async
    test('test getQueue', () async {
      // TODO
    });

    // Mueve y reordena items entre impresoras y la cola sin asignar
    //
    //Future<Queue> reorderQueue(QueueReorderRequest queueReorderRequest) async
    test('test reorderQueue', () async {
      // TODO
    });
  });
}
