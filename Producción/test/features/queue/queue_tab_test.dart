import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/queue/presentation/queue_tab.dart';

void main() {
  testWidgets('muestra columnas sin asignar y por impresora con sus items', (
    tester,
  ) async {
    final realtime = ManualRealtimeClient()..start();
    addTearDown(realtime.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mockLatencyProvider.overrideWithValue(Duration.zero),
          realtimeClientProvider.overrideWithValue(realtime),
        ],
        child: const MaterialApp(home: Scaffold(body: QueueTab())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.queueUnassigned), findsOneWidget);
    expect(find.text('Impresora 1'), findsOneWidget);
    expect(find.text('Impresora 2'), findsOneWidget);

    // Un item sin asignar y uno asignado a la impresora 1.
    expect(find.text('Llavero'), findsOneWidget);
    expect(find.text('Vaso'), findsOneWidget);
  });
}
