import 'package:flutter/material.dart';

/// Tokens de diseño por defecto de la instancia NOVALAB (doc §7).
///
/// Cada negocio puede sobrescribir logo y colores desde `settings`; la app los
/// lee de `GET /api/public/branding`. Estos valores son el fallback.
abstract final class DesignTokens {
  static const Color midnightBlue = Color(0xFF0B132B);
  static const Color neonGreen = Color(0xFF00FF87);
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF4F6FB);
  static const Color danger = Color(0xFFE5484D);
  static const Color warning = Color(0xFFF5A524);

  // Espaciados
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;

  // Radios
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;
}

/// Convierte un color hex (`#RRGGBB` o `#AARRGGBB`) en [Color].
///
/// Devuelve [fallback] si el valor no es válido, para no romper la UI por un
/// `settings` mal capturado.
Color colorFromHex(String? hex, {Color fallback = DesignTokens.midnightBlue}) {
  if (hex == null) return fallback;
  final cleaned = hex.replaceFirst('#', '').trim();
  final value = int.tryParse(cleaned, radix: 16);
  if (value == null) return fallback;
  if (cleaned.length == 6) {
    return Color(0xFF000000 | value);
  }
  if (cleaned.length == 8) {
    return Color(value);
  }
  return fallback;
}
