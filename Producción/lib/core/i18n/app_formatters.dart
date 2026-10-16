import 'package:intl/intl.dart';
import 'package:novalab_api/novalab_api.dart';

/// Formateo de datos según `es-MX` (doc §7: moneda, fecha y zona configurables).
///
/// La app solo presenta; las reglas de negocio viven en el backend. Aquí se
/// centraliza el formateo para no repetir `DateFormat`/`NumberFormat` en widgets.
abstract final class AppFormatters {
  static const String _locale = 'es-MX';

  static const List<String> _months = <String>[
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  /// Fecha media, p. ej. `16 oct 2026`.
  ///
  /// Se formatea a mano (meses en español) para no depender de la carga de
  /// datos de localización de `intl` en tiempo de ejecución.
  static String dateMedium(Date? date) {
    if (date == null) return '';
    final value = date.toDateTime();
    return '${value.day} ${_months[value.month - 1]} ${value.year}';
  }

  /// Monto con la moneda del negocio, p. ej. `$1,250.00`.
  static String currency(num amount, String currencyCode) {
    final format = NumberFormat.currency(
      locale: _locale,
      name: currencyCode,
      symbol: _symbolFor(currencyCode),
    );
    return format.format(amount);
  }

  static String _symbolFor(String currencyCode) => switch (currencyCode) {
    'MXN' => r'$',
    'USD' => r'$',
    'EUR' => '€',
    _ => '$currencyCode ',
  };
}
