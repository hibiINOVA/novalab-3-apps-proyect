import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/i18n/app_formatters.dart';

void main() {
  test('formatea fecha en es-MX', () {
    final formatted = AppFormatters.dateMedium(Date(2026, 10, 16));
    expect(formatted, contains('16'));
    expect(formatted, contains('2026'));
  });

  test('formatea moneda MXN', () {
    expect(AppFormatters.currency(1250, 'MXN'), contains('1,250'));
  });

  test('fecha nula devuelve cadena vacía', () {
    expect(AppFormatters.dateMedium(null), isEmpty);
  });
}
