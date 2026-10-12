import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import 'queue_item_card.dart';

typedef QueueDropCallback =
    void Function(int itemId, int? printerId, int position);

/// Columna de la cola: items sin asignar o de una impresora (P-03).
///
/// Acepta items arrastrados desde cualquier columna. Los huecos entre tarjetas
/// permiten soltar en una posición exacta; el resto de la columna agrega al
/// final.
class QueueColumn extends StatelessWidget {
  const QueueColumn({
    required this.title,
    required this.printerId,
    required this.items,
    required this.onDrop,
    super.key,
  });

  final String title;
  final int? printerId;
  final List<QueueItem> items;
  final QueueDropCallback onDrop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 288,
      margin: const EdgeInsets.only(right: DesignTokens.spaceMd),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceSm),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _CountBadge(count: items.length),
              ],
            ),
          ),
          Expanded(
            child: DragTarget<QueueItem>(
              onAcceptWithDetails: (details) =>
                  onDrop(details.data.id, printerId, items.length),
              builder: (context, candidates, _) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spaceSm,
                    vertical: DesignTokens.spaceXs,
                  ),
                  children: <Widget>[
                    for (var i = 0; i < items.length; i++) ...<Widget>[
                      _DropGap(index: i, printerId: printerId, onDrop: onDrop),
                      _DraggableItem(item: items[i]),
                    ],
                    _DropGap(
                      index: items.length,
                      printerId: printerId,
                      onDrop: onDrop,
                    ),
                    if (items.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(DesignTokens.spaceMd),
                        child: Text(
                          AppStrings.queueEmptyColumn,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Text('$count', style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

/// Hueco soltable que inserta el item en [index].
class _DropGap extends StatelessWidget {
  const _DropGap({
    required this.index,
    required this.printerId,
    required this.onDrop,
  });

  final int index;
  final int? printerId;
  final QueueDropCallback onDrop;

  @override
  Widget build(BuildContext context) {
    return DragTarget<QueueItem>(
      onAcceptWithDetails: (details) =>
          onDrop(details.data.id, printerId, index),
      builder: (context, candidates, _) {
        final active = candidates.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: active ? 28 : 6,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: active
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
        );
      },
    );
  }
}

class _DraggableItem extends StatelessWidget {
  const _DraggableItem({required this.item});

  final QueueItem item;

  @override
  Widget build(BuildContext context) {
    return Draggable<QueueItem>(
      data: item,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 264,
          child: QueueItemCard(item: item, dragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: QueueItemCard(item: item),
      ),
      child: QueueItemCard(item: item),
    );
  }
}
