import 'package:flutter/material.dart';

/// Tokens de diseño por defecto de la instancia NOVALAB (doc §7).
///
/// Paleta derivada del logo: azul marino profundo + verde neon + blanco puro.
/// Identidad eco-friendly: impresión con filamento rPET reciclado,
/// economía circular y sustentabilidad tecnológica.
///
/// Cada negocio puede sobrescribir logo y colores desde `settings`; la app los
/// lee de `GET /api/public/branding`. Estos valores son el fallback.
abstract final class DesignTokens {
  // ─── Paleta primaria del logo ───────────────────────────────────────────────
  /// Azul marino profundo — fondo principal del logo.
  static const Color midnightBlue = Color(0xFF0B132B);

  /// Verde neon eléctrico — acento principal, loop de reciclaje del logo.
  static const Color neonGreen = Color(0xFF00FF87);

  /// Blanco puro — texto e iconos sobre fondo oscuro.
  static const Color white = Color(0xFFFFFFFF);

  // ─── Superficies oscuras (tema dark eco) ────────────────────────────────────
  /// Superficie ligeramente más clara para tarjetas sobre midnightBlue.
  static const Color navySurface = Color(0xFF0F1C3A);

  /// Tarjetas secundarias / paneles laterales.
  static const Color navyCard = Color(0xFF152244);

  /// Borde sutil sobre superficies dark.
  static const Color navyBorder = Color(0xFF1E2D55);

  // ─── Verde eco derivado ──────────────────────────────────────────────────────
  /// Verde eco tenue — fondos de badges de material reciclado.
  static const Color ecoGreenDim = Color(0xFF003D22);

  /// Verde eco secundario — acciones secundarias, hover.
  static const Color ecoGreenSecondary = Color(0xFF00CC6A);

  /// Verde eco muy claro — para temas claros (futuro).
  static const Color ecoGreenLight = Color(0xFFE8FFF5);

  // ─── Semánticos ─────────────────────────────────────────────────────────────
  /// Superficie general en tema claro (fallback cuando no hay dark).
  static const Color surface = Color(0xFFF4F6FB);

  /// Error / peligro.
  static const Color danger = Color(0xFFE5484D);

  /// Advertencia.
  static const Color warning = Color(0xFFF5A524);

  // ─── Espaciados ─────────────────────────────────────────────────────────────
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;

  // ─── Radios ─────────────────────────────────────────────────────────────────
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;

  // ─── Materiales eco-friendly (rPET) ─────────────────────────────────────────
  /// Materiales considerados reciclados/eco-friendly para badge verde.
  static const Set<String> ecoMaterials = <String>{
    'rPET',
    'RPET',
    'PETG',
    'PLA',
    'rPLA',
  };
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
