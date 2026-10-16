import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/app.dart';
import 'package:produccion/core/api/mock/mock_backend.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/auth/auth_providers.dart';
import 'package:produccion/features/auth/data/auth_token_store.dart';

Future<void> _pumpApp(WidgetTester tester, InMemoryAuthTokenStore store) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authTokenStoreProvider.overrideWithValue(store),
        mockLatencyProvider.overrideWithValue(Duration.zero),
        realtimeClientProvider.overrideWithValue(
          ManualRealtimeClient()..start(),
        ),
      ],
      child: const NovalabApp(),
    ),
  );
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('desde login se abre registro y crea una cuenta', (tester) async {
    final store = InMemoryAuthTokenStore();
    await _pumpApp(tester, store);

    // Enlace desde login → registro.
    await tester.tap(find.byKey(const Key('go-to-register')));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.registerSubtitle), findsOneWidget);
    expect(find.text(AppStrings.registerGoToLogin), findsOneWidget);

    // Validaciones: confirmar contraseña vacía no coincide.
    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(4));
    await tester.enterText(fields.at(0), 'Nueva Cuenta');
    await tester.enterText(fields.at(1), 'nueva@ejemplo.mx');
    await tester.enterText(fields.at(2), 'secreta123');
    await tester.enterText(fields.at(3), 'diferente');
    await tester.tap(
      find.widgetWithText(FilledButton, AppStrings.registerSubmit),
    );
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.registerPasswordMismatch), findsOneWidget);

    // Contraseña corta → aviso.
    await tester.enterText(fields.at(2), '123');
    await tester.enterText(fields.at(3), '123');
    await tester.tap(
      find.widgetWithText(FilledButton, AppStrings.registerSubmit),
    );
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.registerPasswordTooShort), findsOneWidget);

    // Registro correcto de operador → sesión iniciada y guardia redirige a unirse a organización.
    await tester.enterText(fields.at(2), 'secreta123');
    await tester.enterText(fields.at(3), 'secreta123');
    await tester.tap(
      find.widgetWithText(FilledButton, AppStrings.registerSubmit),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.orgJoinTitle), findsOneWidget);
    expect(await store.read(), isNotNull);
  });

  testWidgets('correo ya registrado muestra el aviso del mock', (tester) async {
    final store = InMemoryAuthTokenStore();
    await _pumpApp(tester, store);

    await tester.tap(find.byKey(const Key('go-to-register')));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Duplicada');
    await tester.enterText(fields.at(1), kMockOwnerEmail);
    await tester.enterText(fields.at(2), 'secreta123');
    await tester.enterText(fields.at(3), 'secreta123');
    await tester.tap(
      find.widgetWithText(FilledButton, AppStrings.registerSubmit),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('register-error')), findsOneWidget);
    expect(find.text(AppStrings.registerEmailTaken), findsOneWidget);
    expect(await store.read(), isNull);
  });
}
