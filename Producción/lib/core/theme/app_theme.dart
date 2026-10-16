import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import 'design_tokens.dart';

/// Tema oscuro eco-friendly derivado de la marca NOVALAB.
///
/// Paleta: azul marino profundo (#0B132B) + verde neon (#00FF87) + blanco.
/// Inspirado en el logo: economía circular, rPET reciclado, sustentabilidad.
abstract final class AppTheme {
  static ThemeData fromBranding(Branding branding) {
    // Leer colores de branding; si no vienen, usar los del logo NOVALAB.
    final primary = colorFromHex(
      branding.accentColor, // verde neon como primario de acción
      fallback: DesignTokens.neonGreen,
    );
    final background = colorFromHex(
      branding.primaryColor, // navy como fondo
      fallback: DesignTokens.midnightBlue,
    );

    final scheme = ColorScheme(
      brightness: Brightness.dark,
      // Acciones primarias: verde neon
      primary: primary,
      onPrimary: DesignTokens.midnightBlue,
      primaryContainer: DesignTokens.ecoGreenDim,
      onPrimaryContainer: DesignTokens.neonGreen,
      // Secundario: verde eco tenue
      secondary: DesignTokens.ecoGreenSecondary,
      onSecondary: DesignTokens.midnightBlue,
      secondaryContainer: DesignTokens.ecoGreenDim,
      onSecondaryContainer: DesignTokens.ecoGreenLight,
      // Terciario: blanco con opacidad
      tertiary: const Color(0xFFB0BEC5),
      onTertiary: DesignTokens.midnightBlue,
      tertiaryContainer: DesignTokens.navyCard,
      onTertiaryContainer: DesignTokens.white,
      // Error
      error: DesignTokens.danger,
      onError: DesignTokens.white,
      errorContainer: const Color(0xFF5C1A1C),
      onErrorContainer: const Color(0xFFFFB3B5),
      // Fondos
      surface: DesignTokens.navySurface,
      onSurface: DesignTokens.white,
      surfaceContainerHighest: DesignTokens.navyCard,
      surfaceContainerHigh: DesignTokens.navyCard,
      surfaceContainer: DesignTokens.navySurface,
      surfaceContainerLow: background,
      surfaceContainerLowest: background,
      onSurfaceVariant: const Color(0xFFB0BEC5),
      // Outline
      outline: DesignTokens.navyBorder,
      outlineVariant: DesignTokens.navyBorder,
      // Inversión
      inverseSurface: DesignTokens.white,
      onInverseSurface: DesignTokens.midnightBlue,
      inversePrimary: DesignTokens.ecoGreenSecondary,
      // Sombra
      shadow: Colors.black87,
      scrim: Colors.black54,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,

      // ── AppBar ──────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: DesignTokens.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black54,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: DesignTokens.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: DesignTokens.neonGreen),
        actionsIconTheme: const IconThemeData(color: DesignTokens.neonGreen),
      ),

      // ── Tarjetas ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: DesignTokens.navySurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          side: const BorderSide(color: DesignTokens.navyBorder),
        ),
      ),

      // ── Botones primarios ─────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: DesignTokens.neonGreen,
          foregroundColor: DesignTokens.midnightBlue,
          minimumSize: const Size(0, 48),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
        ),
      ),

      // ── Botones de texto ──────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: DesignTokens.neonGreen),
      ),

      // ── Botones de contorno ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DesignTokens.neonGreen,
          side: const BorderSide(color: DesignTokens.neonGreen),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
        ),
      ),

      // ── Inputs ───────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.navyCard,
        labelStyle: const TextStyle(color: Color(0xFF90A4AE)),
        hintStyle: const TextStyle(color: Color(0xFF546E7A)),
        prefixIconColor: DesignTokens.ecoGreenSecondary,
        suffixIconColor: DesignTokens.ecoGreenSecondary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: const BorderSide(color: DesignTokens.navyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: const BorderSide(color: DesignTokens.neonGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: const BorderSide(color: DesignTokens.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: const BorderSide(color: DesignTokens.danger, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
      ),

      // ── NavigationRail ───────────────────────────────────────────────────────
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: DesignTokens.midnightBlue,
        selectedIconTheme: IconThemeData(color: DesignTokens.neonGreen),
        unselectedIconTheme: IconThemeData(color: Color(0xFF78909C)),
        selectedLabelTextStyle: TextStyle(
          color: DesignTokens.neonGreen,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF78909C)),
        indicatorColor: DesignTokens.ecoGreenDim,
      ),

      // ── NavigationBar (móvil) ────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DesignTokens.midnightBlue,
        indicatorColor: DesignTokens.ecoGreenDim,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: DesignTokens.neonGreen);
          }
          return const IconThemeData(color: Color(0xFF78909C));
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: DesignTokens.neonGreen,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            );
          }
          return const TextStyle(color: Color(0xFF78909C), fontSize: 12);
        }),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black54,
        elevation: 8,
      ),

      // ── Divisor ──────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: DesignTokens.navyBorder,
        thickness: 1,
      ),

      // ── SnackBar ─────────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: DesignTokens.navyCard,
        contentTextStyle: const TextStyle(color: DesignTokens.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          side: const BorderSide(color: DesignTokens.neonGreen),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: DesignTokens.neonGreen,
      ),

      // ── Dialog ───────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: DesignTokens.navySurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          side: const BorderSide(color: DesignTokens.navyBorder),
        ),
      ),

      // ── Chips ────────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: DesignTokens.navyCard,
        selectedColor: DesignTokens.ecoGreenDim,
        labelStyle: const TextStyle(color: DesignTokens.white),
        side: const BorderSide(color: DesignTokens.navyBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
      ),

      // ── Tipografía base ──────────────────────────────────────────────────────
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: DesignTokens.white,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: TextStyle(
          color: DesignTokens.white,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: DesignTokens.white,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(color: DesignTokens.white, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: DesignTokens.white, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: DesignTokens.white),
        bodyLarge: TextStyle(color: DesignTokens.white),
        bodyMedium: TextStyle(color: Color(0xFFB0BEC5)),
        bodySmall: TextStyle(color: Color(0xFF90A4AE)),
        labelLarge: TextStyle(
          color: DesignTokens.neonGreen,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(color: Color(0xFFB0BEC5)),
        labelSmall: TextStyle(color: Color(0xFF90A4AE)),
      ),

      // ── ProgressIndicator ────────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: DesignTokens.neonGreen,
        linearTrackColor: DesignTokens.ecoGreenDim,
      ),

      // ── IconButton ───────────────────────────────────────────────────────────
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: DesignTokens.neonGreen),
      ),
    );
  }
}
