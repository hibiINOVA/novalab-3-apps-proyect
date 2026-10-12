import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/queue/presentation/queue_tab.dart';

Future<void> _pumpQueue(WidgetTester tester) async {
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
}

void main() {
  testWidgets('el botón de sugerir muestra la propuesta con explicaciones', (
    tester,
  ) async {
    await _pumpQueue(tester);

    await tester.tap(find.text(AppStrings.queueSuggest));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.suggestTitle), findsOneWidget);
    // Los dos items sin asignar (Llavero y Maceta) reciben sugerencia.
    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(find.text(AppStrings.suggestAcceptAll), findsOneWidget);
    expect(find.text(AppStrings.suggestAcceptSelected), findsOneWidget);
  });

  testWidgets('aceptar todo asigna los items y vacía "sin asignar"', (
    tester,
  ) async {
    await _pumpQueue(tester);

    await tester.tap(find.text(AppStrings.queueSuggest));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.suggestAcceptAll));
    await tester.pumpAndSettle();

    // La columna "sin asignar" queda vacía y aparece el aviso de aplicado.
    expect(find.text(AppStrings.queueEmptyColumn), findsWidgets);
    expect(find.text(AppStrings.suggestApplied), findsOneWidget);
  });

  testWidgets('descartar deja la cola intacta', (tester) async {
    await _pumpQueue(tester);

    await tester.tap(find.text(AppStrings.queueSuggest));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.suggestDiscard));
    await tester.pumpAndSettle();

    expect(find.text('Llavero'), findsOneWidget);
    expect(find.text(AppStrings.suggestApplied), findsNothing);
  });
}
