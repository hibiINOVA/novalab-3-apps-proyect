import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/realtime/realtime_client.dart';
import '../../../core/realtime/realtime_providers.dart';
import '../../../core/theme/design_tokens.dart';
import '../printers_providers.dart';
import 'printer_card.dart';
import 'printer_form_dialog.dart';

/// Tablero de impresoras (P-02).
///
/// Una tarjeta por impresora, con actualización en vivo. El estado se refresca
/// al recibir eventos del canal `/ws`; una impresora sin conexión se aísla.
class PrintersTab extends ConsumerWidget {
  const PrintersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printers = ref.watch(printersProvider);

    return Column(
      children: <Widget>[
        const _LiveBar(),
        Expanded(
          child: printers.when(
            data: (list) => list.isEmpty
                ? const _CenteredMessage(
                    text: AppStrings.printersEmpty,
                    icon: Icons.print_disabled_outlined,
                  )
                : _PrintersGrid(printers: list),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => _ErrorState(
              onRetry: () => ref.read(printersProvider.notifier).refresh(),
            ),
          ),
        ),
      ],
    );
  }
}

class _LiveBar extends ConsumerWidget {
  const _LiveBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(realtimeStatusProvider);
    final (label, color) = switch (status) {
      RealtimeStatus.connected => (
        AppStrings.printerLive,
        DesignTokens.neonGreen,
      ),
      RealtimeStatus.connecting => (
        AppStrings.printerConnecting,
        DesignTokens.warning,
      ),
      RealtimeStatus.disconnected => (
        AppStrings.printerNoConnection,
        DesignTokens.danger,
      ),
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.spaceMd,
        DesignTokens.spaceMd,
        DesignTokens.spaceMd,
        0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              AppStrings.printersTitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: DesignTokens.spaceMd),
          FilledButton.tonalIcon(
            onPressed: () => PrinterFormDialog.show(context),
            icon: const Icon(Icons.add, size: 18),
            label: const Text(AppStrings.printerAdd),
          ),
          const Spacer(),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: DesignTokens.spaceXs),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _PrintersGrid extends StatelessWidget {
  const _PrintersGrid({required this.printers});

  final List<Printer> printers;

  @override
  Widget build(BuildContext context) {
    const spacing = DesignTokens.spaceMd;
    const maxExtent = 440.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / maxExtent).floor().clamp(1, 4);
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(spacing),
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              for (final printer in printers)
                SizedBox(
                  width: cardWidth,
                  child: PrinterCard(printer: printer),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 40, color: scheme.onSurfaceVariant),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error_outline, size: 40, color: DesignTokens.danger),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            AppStrings.printersLoadError,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          FilledButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
        ],
      ),
    );
  }
}
