import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import 'design_tokens.dart';

/// Tema claro construido a partir de la marca del negocio.
abstract final class AppTheme {
  static ThemeData fromBranding(Branding branding) {
    final primary = colorFromHex(
      branding.primaryColor,
      fallback: DesignTokens.midnightBlue,
    );
    final accent = colorFromHex(
      branding.accentColor,
      fallback: DesignTokens.neonGreen,
    );
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: accent,
      surface: DesignTokens.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: DesignTokens.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: DesignTokens.white,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
      ),
    );
  }
}
