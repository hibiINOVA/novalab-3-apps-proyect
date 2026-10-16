import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/printers/presentation/printers_tab.dart';

void main() {
  testWidgets('muestra una tarjeta por impresora y el indicador en vivo', (
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
        child: const MaterialApp(home: Scaffold(body: PrintersTab())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Impresora 1'), findsOneWidget);
    expect(find.text('Impresora 2'), findsOneWidget);
    expect(find.text('Impresora 3'), findsOneWidget);
    expect(find.text(AppStrings.printerStatePrinting), findsOneWidget);
    expect(find.text(AppStrings.printerLive), findsOneWidget);
    expect(find.text(AppStrings.printerStateOffline), findsOneWidget);
  });
}
