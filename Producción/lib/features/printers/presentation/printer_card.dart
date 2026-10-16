import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import 'printer_camera.dart';
import 'printer_state_view.dart';

/// Tarjeta de una impresora en el tablero (P-02).
///
/// Muestra estado, progreso, tiempo restante, temperaturas, miniatura de
/// cámara, spool cargado y pedido actual. Una impresora sin conexión se aísla:
/// se atenúa y explica su estado sin afectar al resto.
class PrinterCard extends StatelessWidget {
  const PrinterCard({required this.printer, super.key});

  final Printer printer;

  @override
  Widget build(BuildContext context) {
    final stateView = PrinterStateView.of(printer.state);
    final offline = printer.state == PrinterState.offline;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Opacity(
        opacity: offline ? 0.65 : 1,
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _Header(printer: printer, stateView: stateView),
              const SizedBox(height: DesignTokens.spaceSm),
              if (offline)
                Text(
                  AppStrings.printerDisconnectedHint,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              else ...<Widget>[
                PrinterCamera(
                  printerId: printer.id,
                  available: printer.cameraAvailable ?? false,
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                if (printer.state == PrinterState.printing ||
                    printer.state == PrinterState.paused)
                  _Progress(printer: printer),
                _Temperatures(printer: printer),
                _Details(printer: printer),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.printer, required this.stateView});

  final Printer printer;
  final PrinterStateView stateView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            printer.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: DesignTokens.spaceSm),
        _StateChip(stateView: stateView),
      ],
    );
  }
}

class _StateChip extends StatelessWidget {
  const _StateChip({required this.stateView});

  final PrinterStateView stateView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceSm,
        vertical: DesignTokens.spaceXs,
      ),
      decoration: BoxDecoration(
        color: stateView.color,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(stateView.icon, size: 16, color: stateView.onColor),
          const SizedBox(width: DesignTokens.spaceXs),
          Text(
            stateView.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: stateView.onColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.printer});

  final Printer printer;

  @override
  Widget build(BuildContext context) {
    final progress = (printer.progress ?? 0).clamp(0, 100).toDouble();
    final remaining = printer.remainingSeconds;
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            child: LinearProgressIndicator(value: progress / 100, minHeight: 8),
          ),
          const SizedBox(height: DesignTokens.spaceXs),
          Row(
            children: <Widget>[
              Text(
                '${progress.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              if (remaining != null)
                Text(
                  '${AppStrings.printerRemaining}: ${_formatDuration(remaining)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
          if (printer.currentFile != null &&
              printer.currentFile!.isNotEmpty) ...<Widget>[
            const SizedBox(height: DesignTokens.spaceXs),
            Text(
              '${AppStrings.printerFile}: ${printer.currentFile}',
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

class _Temperatures extends StatelessWidget {
  const _Temperatures({required this.printer});

  final Printer printer;

  @override
  Widget build(BuildContext context) {
    final nozzle = _temp(printer.nozzleTemp, printer.nozzleTarget);
    final bed = _temp(printer.bedTemp, printer.bedTarget);
    if (nozzle == null && bed == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
      child: Wrap(
        spacing: DesignTokens.spaceSm,
        runSpacing: DesignTokens.spaceXs,
        children: <Widget>[
          if (nozzle != null)
            _Chip(
              icon: Icons.thermostat,
              text: '${AppStrings.printerNozzle} $nozzle',
            ),
          if (bed != null)
            _Chip(icon: Icons.bed, text: '${AppStrings.printerBed} $bed'),
        ],
      ),
    );
  }

  static String? _temp(double? current, double? target) {
    if (current == null) return null;
    final value = '${current.toStringAsFixed(0)}°';
    if (target == null) return value;
    return '$value / ${target.toStringAsFixed(0)}°';
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceSm,
        vertical: DesignTokens.spaceXs,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: scheme.onSurfaceVariant),
          const SizedBox(width: DesignTokens.spaceXs),
          Text(text, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.printer});

  final Printer printer;

  @override
  Widget build(BuildContext context) {
    final spool = printer.loadedSpool;
    final order = printer.currentOrder;
    final grams = spool?.gramsRemaining;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _DetailRow(
          icon: Icons.inventory_2_outlined,
          text: spool == null
              ? AppStrings.printerNoSpool
              : '${spool.material} · ${spool.color}'
                    '${grams == null ? '' : ' · ${grams.toStringAsFixed(0)} ${AppStrings.printerGramsRemaining}'}',
        ),
        const SizedBox(height: DesignTokens.spaceXs),
        _DetailRow(
          icon: Icons.receipt_long_outlined,
          text: order == null
              ? AppStrings.printerNoOrder
              : '${order.folio} · ${order.customerName}',
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: scheme.onSurfaceVariant),
        const SizedBox(width: DesignTokens.spaceSm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

String _formatDuration(int seconds) {
  if (seconds <= 0) return '0 min';
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  if (hours > 0) {
    return minutes > 0 ? '$hours h $minutes min' : '$hours h';
  }
  if (minutes > 0) return '$minutes min';
  return '< 1 min';
}
