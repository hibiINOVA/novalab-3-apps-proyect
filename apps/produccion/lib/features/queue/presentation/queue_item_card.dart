import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';

/// Tarjeta de un item de la cola (P-03).
class QueueItemCard extends StatelessWidget {
  const QueueItemCard({required this.item, this.dragging = false, super.key});

  final QueueItem item;
  final bool dragging;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final state = _QueueStateView.of(item.state);

    return Card(
      elevation: dragging ? 8 : 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spaceSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    item.productName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceXs),
                _StateBadge(view: state),
              ],
            ),
            const SizedBox(height: DesignTokens.spaceXs),
            Row(
              children: <Widget>[
                Icon(
                  Icons.receipt_long_outlined,
                  size: 14,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: DesignTokens.spaceXs),
                Expanded(
                  child: Text(
                    item.orderFolio,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.color != null && item.color!.isNotEmpty) ...<Widget>[
                  const SizedBox(width: DesignTokens.spaceSm),
                  _ColorDot(color: item.color!),
                ],
              ],
            ),
            const SizedBox(height: DesignTokens.spaceXs),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${item.printedQuantity}/${item.quantity} '
                    '${AppStrings.queuePieces}',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.missingQuantity != null && item.missingQuantity! > 0)
                  Text(
                    '${AppStrings.queueMissing}: ${item.missingQuantity}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: DesignTokens.danger),
                  ),
              ],
            ),
            if (item.estimatedMinutes != null) ...<Widget>[
              const SizedBox(height: DesignTokens.spaceXs),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.schedule,
                    size: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: DesignTokens.spaceXs),
                  Text(
                    '~${item.estimatedMinutes} ${AppStrings.queueEstimated}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.view});

  final _QueueStateView view;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceSm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: view.color,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Text(
        view.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: view.onColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color});

  final String color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: _colorFromName(color),
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.spaceXs),
        Text(color, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _QueueStateView {
  const _QueueStateView(this.label, this.color, this.onColor);

  final String label;
  final Color color;
  final Color onColor;

  static _QueueStateView of(QueueItemState state) {
    switch (state) {
      case QueueItemState.printing:
        return const _QueueStateView(
          AppStrings.printerStatePrinting,
          DesignTokens.neonGreen,
          DesignTokens.midnightBlue,
        );
      case QueueItemState.printed:
        return _QueueStateView(
          AppStrings.queueStatePrinted,
          DesignTokens.midnightBlue.withValues(alpha: 0.12),
          DesignTokens.midnightBlue,
        );
      case QueueItemState.failed:
        return const _QueueStateView(
          AppStrings.queueStateFailed,
          DesignTokens.danger,
          DesignTokens.white,
        );
      case QueueItemState.queued:
        return _QueueStateView(
          AppStrings.queueStateQueued,
          DesignTokens.midnightBlue.withValues(alpha: 0.08),
          DesignTokens.midnightBlue,
        );
      case QueueItemState.pending:
        return _QueueStateView(
          AppStrings.queueStatePending,
          DesignTokens.warning,
          DesignTokens.midnightBlue,
        );
      default:
        return _QueueStateView(
          state.name,
          DesignTokens.midnightBlue.withValues(alpha: 0.08),
          DesignTokens.midnightBlue,
        );
    }
  }
}

/// Aproximación de color de filamento por nombre; no es lógica de negocio.
Color _colorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'negro':
      return const Color(0xFF222222);
    case 'blanco':
      return const Color(0xFFF2F2F2);
    case 'rojo':
      return const Color(0xFFE5484D);
    case 'verde':
      return const Color(0xFF30A46C);
    case 'azul':
      return const Color(0xFF3B82F6);
    case 'amarillo':
      return const Color(0xFFF5A524);
    default:
      return const Color(0xFF9CA3AF);
  }
}
