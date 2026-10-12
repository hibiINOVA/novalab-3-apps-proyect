import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/queue/queue_providers.dart';

void main() {
  ProviderContainer container() {
    final realtime = ManualRealtimeClient()..start();
    addTearDown(realtime.close);
    return ProviderContainer(
      overrides: [
        mockLatencyProvider.overrideWithValue(Duration.zero),
        realtimeClientProvider.overrideWithValue(realtime),
      ],
    );
  }

  test('carga la cola con columnas sin asignar y por impresora', () async {
    final providerContainer = container();
    addTearDown(providerContainer.dispose);

    final queue = await providerContainer.read(queueProvider.future);
    expect(queue.unassigned.map((i) => i.id), containsAll(<int>[5, 6]));
    expect(queue.byPrinter['1']?.map((i) => i.id), containsAll(<int>[1]));
    expect(queue.byPrinter['2']?.map((i) => i.id), containsAll(<int>[2, 3]));
  });

  test('mueve un item de "sin asignar" a una impresora', () async {
    final providerContainer = container();
    addTearDown(providerContainer.dispose);

    await providerContainer.read(queueProvider.future);
    final ok = await providerContainer
        .read(queueProvider.notifier)
        .moveItem(itemId: 6, printerId: 1, position: 0);
    expect(ok, isTrue);

    final updated = providerContainer.read(queueProvider).value!;
    expect(updated.byPrinter['1']!.first.id, 6);
    expect(updated.unassigned.map((i) => i.id), isNot(contains(6)));
    // Posiciones normalizadas.
    expect(updated.byPrinter['1']!.first.position, 0);
    expect(updated.byPrinter['1']!.elementAt(1).position, 1);
  });
}
