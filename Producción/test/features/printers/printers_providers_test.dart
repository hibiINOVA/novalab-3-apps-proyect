import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_message.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/printers/printers_providers.dart';

void main() {
  test('carga impresoras y se refresca ante eventos en vivo', () async {
    final realtime = ManualRealtimeClient()..start();
    final container = ProviderContainer(
      overrides: [
        mockLatencyProvider.overrideWithValue(Duration.zero),
        realtimeClientProvider.overrideWithValue(realtime),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(realtime.close);

    final printers = await container.read(printersProvider.future);
    expect(printers, hasLength(3));
    expect(printers.first.state, PrinterState.printing);
    expect(printers.first.progress, closeTo(42.5, 0.001));
    expect(printers.last.state, PrinterState.offline);

    // El backend simulado avanza y el canal en vivo notifica el cambio.
    container.read(apiClientFactoryProvider).mockBackend.tick();
    realtime.emit(
      const RealtimeMessage(
        type: 'printer.state',
        entity: 'printer',
        entityId: 1,
      ),
    );

    final deadline = DateTime.now().add(const Duration(seconds: 2));
    while ((container.read(printersProvider).value?.first.progress ?? 0) <=
        43) {
      expect(DateTime.now().isBefore(deadline), isTrue, reason: 'sin refresco');
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }

    final refreshed = container.read(printersProvider).value!;
    expect(refreshed.first.progress, closeTo(45.0, 0.001));
  });

  test('la cámara devuelve bytes o null según disponibilidad', () async {
    final container = ProviderContainer(
      overrides: [
        mockLatencyProvider.overrideWithValue(Duration.zero),
        realtimeClientProvider.overrideWithValue(ManualRealtimeClient()),
      ],
    );
    addTearDown(container.dispose);

    final bytes = await container.read(printerCameraSnapshotProvider(1).future);
    expect(bytes, isNotNull);
    expect(bytes, isNotEmpty);

    final unavailable = await container.read(
      printerCameraSnapshotProvider(3).future,
    );
    expect(unavailable, isNull);
  });
}
