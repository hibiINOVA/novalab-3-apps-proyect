import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/app.dart';
import 'package:produccion/core/api/mock/mock_backend.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/features/auth/auth_providers.dart';
import 'package:produccion/features/auth/data/auth_token_store.dart';

void main() {
  testWidgets('login entra al tablero y logout regresa al login', (
    tester,
  ) async {
    final store = InMemoryAuthTokenStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authTokenStoreProvider.overrideWithValue(store)],
        child: const NovalabApp(),
      ),
    );
    // Deja responder al backend simulado.
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginSubmit), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), kMockOwnerEmail);
    await tester.enterText(find.byType(TextFormField).at(1), kMockPassword);
    await tester.tap(find.widgetWithText(FilledButton, AppStrings.loginSubmit));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.navPrinters), findsOneWidget);
    expect(await store.read(), isNotNull);

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginSubmit), findsOneWidget);
  });

  testWidgets('credenciales incorrectas muestran un aviso', (tester) async {
    final store = InMemoryAuthTokenStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authTokenStoreProvider.overrideWithValue(store)],
        child: const NovalabApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), kMockOwnerEmail);
    await tester.enterText(find.byType(TextFormField).at(1), 'incorrecta');
    await tester.tap(find.widgetWithText(FilledButton, AppStrings.loginSubmit));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginGenericError), findsOneWidget);
    expect(await store.read(), isNull);
  });
}
