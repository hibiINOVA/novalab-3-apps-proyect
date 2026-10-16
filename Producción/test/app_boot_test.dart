import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/app.dart';
import 'package:produccion/core/i18n/app_strings.dart';

void main() {
  testWidgets('sin sesión la app arranca en la pantalla de login', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: NovalabApp()));
    // Deja responder al backend simulado (tiene latencia artificial).
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.loginSubmit), findsOneWidget);
  });
}
