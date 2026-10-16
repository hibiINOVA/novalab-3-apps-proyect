import 'package:flutter/material.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';

/// Diálogo de propuesta de asignación (P-04).
///
/// Muestra cada sugerencia con su explicación (BE-14) y permite aceptar todo,
/// aceptar solo algunas o descartar. Devuelve el conjunto de `item_id` aceptados
/// o `null` si se descarta.
class SuggestionDialog extends StatefulWidget {
  const SuggestionDialog({super.key, required this.suggestion});

  final QueueSuggestion suggestion;

  static Future<Set<int>?> show(
    BuildContext context,
    QueueSuggestion suggestion,
  ) {
    return showDialog<Set<int>>(
      context: context,
      builder: (_) => SuggestionDialog(suggestion: suggestion),
    );
  }

  @override
  State<SuggestionDialog> createState() => _SuggestionDialogState();
}

class _SuggestionDialogState extends State<SuggestionDialog> {
  late final Set<int> _all = widget.suggestion.assignments
      .map((a) => a.itemId)
      .toSet();
  late final Set<int> _selected = <int>{..._all};

  @override
  Widget build(BuildContext context) {
    final assignments = widget.suggestion.assignments;
    final empty = assignments.isEmpty;
    final summary = widget.suggestion.summary;

    return AlertDialog(
      title: const Text(AppStrings.suggestTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 420),
        child: empty
            ? const Text(AppStrings.suggestEmpty)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (summary != null && summary.isNotEmpty) ...<Widget>[
                    Text(summary),
                    const SizedBox(height: DesignTokens.spaceSm),
                  ],
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (final a in assignments)
                            CheckboxListTile(
                              value: _selected.contains(a.itemId),
                              onChanged: (checked) => setState(() {
                                if (checked ?? false) {
                                  _selected.add(a.itemId);
                                } else {
                                  _selected.remove(a.itemId);
                                }
                              }),
                              title: Text(a.productName ?? a.orderFolio ?? ''),
                              subtitle: Text(
                                a.explanation,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              secondary: const Icon(Icons.auto_awesome),
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      actions: empty
          ? <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(AppStrings.suggestDiscard),
              ),
            ]
          : <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(AppStrings.suggestDiscard),
              ),
              TextButton(
                onPressed: _selected.isEmpty
                    ? null
                    : () => Navigator.of(context).pop(<int>{..._selected}),
                child: const Text(AppStrings.suggestAcceptSelected),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(<int>{..._all}),
                child: const Text(AppStrings.suggestAcceptAll),
              ),
            ],
    );
  }
}
