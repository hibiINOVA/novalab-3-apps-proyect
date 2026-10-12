import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';

/// Presentación (etiqueta, color e icono) de cada [PrinterState].
///
/// Solo presentación: el estado real y sus transiciones viven en el backend.
class PrinterStateView {
  const PrinterStateView({
    required this.label,
    required this.color,
    required this.onColor,
    required this.icon,
  });

  final String label;
  final Color color;
  final Color onColor;
  final IconData icon;

  static PrinterStateView of(PrinterState state) {
    switch (state) {
      case PrinterState.printing:
        return const PrinterStateView(
          label: AppStrings.printerStatePrinting,
          color: DesignTokens.neonGreen,
          onColor: DesignTokens.midnightBlue,
          icon: Icons.play_circle_outline,
        );
      case PrinterState.paused:
        return const PrinterStateView(
          label: AppStrings.printerStatePaused,
          color: DesignTokens.warning,
          onColor: DesignTokens.midnightBlue,
          icon: Icons.pause_circle_outline,
        );
      case PrinterState.offline:
        return PrinterStateView(
          label: AppStrings.printerStateOffline,
          color: DesignTokens.midnightBlue.withValues(alpha: 0.12),
          onColor: DesignTokens.midnightBlue,
          icon: Icons.cloud_off_outlined,
        );
      case PrinterState.error:
        return const PrinterStateView(
          label: AppStrings.printerStateError,
          color: DesignTokens.danger,
          onColor: DesignTokens.white,
          icon: Icons.error_outline,
        );
      case PrinterState.idle:
        return PrinterStateView(
          label: AppStrings.printerStateIdle,
          color: DesignTokens.midnightBlue.withValues(alpha: 0.08),
          onColor: DesignTokens.midnightBlue,
          icon: Icons.check_circle_outline,
        );
      default:
        return PrinterStateView(
          label: state.name,
          color: DesignTokens.midnightBlue.withValues(alpha: 0.08),
          onColor: DesignTokens.midnightBlue,
          icon: Icons.print_outlined,
        );
    }
  }
}
