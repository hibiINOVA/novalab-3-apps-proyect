import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../../printers/printers_providers.dart';
import '../queue_providers.dart';
import 'queue_column.dart';
import 'suggestion_dialog.dart';

/// Cola de producción (P-03): columnas por impresora más "sin asignar".
///
/// Los items se arrastran entre columnas y se reordenan; el backend confirma el
/// cambio y la app revierte si hay conflicto de versión. Incluye el botón de
/// "Sugerir asignación" (P-04).
class QueueTab extends ConsumerStatefulWidget {
  const QueueTab({super.key});

  @override
  ConsumerState<QueueTab> createState() => _QueueTabState();
}

class _QueueTabState extends ConsumerState<QueueTab> {
  bool _requesting = false;

  @override
  Widget build(BuildContext context) {
    final queue = ref.watch(queueProvider);
    final printers = ref.watch(printersProvider).value ?? const <Printer>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
            DesignTokens.spaceMd,
            DesignTokens.spaceMd,
            DesignTokens.spaceMd,
            DesignTokens.spaceSm,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  AppStrings.queueTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: _requesting ? null : _handleSuggest,
                icon: _requesting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: const Text(AppStrings.queueSuggest),
              ),
            ],
          ),
        ),
        Expanded(
          child: queue.when(
            data: (value) => _QueueBoard(
              queue: value,
              printers: printers,
              onDrop: (itemId, printerId, position) => _handleDrop(
                itemId: itemId,
                printerId: printerId,
                position: position,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => _ErrorState(
              onRetry: () => ref.read(queueProvider.notifier).refresh(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleDrop({
    required int itemId,
    required int? printerId,
    required int position,
  }) async {
    final ok = await ref
        .read(queueProvider.notifier)
        .moveItem(itemId: itemId, printerId: printerId, position: position);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.queueReorderError)),
      );
    }
  }

  Future<void> _handleSuggest() async {
    setState(() => _requesting = true);
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(queueProvider.notifier);
    try {
      final suggestion = await controller.requestSuggestion();
      if (!mounted) return;
      setState(() => _requesting = false);

      final accepted = await SuggestionDialog.show(context, suggestion);
      if (accepted == null || !mounted) return;

      final ok = await controller.acceptSuggestion(
        suggestion,
        itemIds: accepted,
      );
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            ok ? AppStrings.suggestApplied : AppStrings.queueReorderError,
          ),
        ),
      );
    } catch (_) {
      if (mounted) setState(() => _requesting = false);
      messenger.showSnackBar(
        const SnackBar(content: Text(AppStrings.suggestError)),
      );
    }
  }
}

class _QueueBoard extends StatelessWidget {
  const _QueueBoard({
    required this.queue,
    required this.printers,
    required this.onDrop,
  });

  final Queue queue;
  final List<Printer> printers;
  final QueueDropCallback onDrop;

  @override
  Widget build(BuildContext context) {
    final columns = <Widget>[
      QueueColumn(
        title: AppStrings.queueUnassigned,
        printerId: null,
        items: queue.unassigned.toList(),
        onDrop: onDrop,
      ),
    ];

    final known = <int>{};
    for (final printer in printers) {
      known.add(printer.id);
      columns.add(
        QueueColumn(
          title: printer.name,
          printerId: printer.id,
          items: _itemsFor(printer.id),
          onDrop: onDrop,
        ),
      );
    }

    queue.byPrinter.forEach((key, list) {
      final id = int.tryParse(key);
      if (id == null || known.contains(id)) return;
      columns.add(
        QueueColumn(
          title: '#$id',
          printerId: id,
          items: list.toList(),
          onDrop: onDrop,
        ),
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns,
      ),
    );
  }

  List<QueueItem> _itemsFor(int printerId) =>
      queue.byPrinter['$printerId']?.toList() ?? <QueueItem>[];
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
            AppStrings.queueLoadError,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          FilledButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
        ],
      ),
    );
  }
}
