import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../organization_providers.dart';

/// Diálogo para que el Dueño gestione las solicitudes de operadores en espera.
class OrganizationRequestsDialog extends ConsumerWidget {
  const OrganizationRequestsDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const OrganizationRequestsDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingRequestsProvider);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.group_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: DesignTokens.spaceSm),
          const Text(AppStrings.orgRequestsTitle),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: requestsAsync.when(
          data: (requests) {
            if (requests.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spaceLg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      AppStrings.orgRequestsEmpty,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: requests.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final req = requests[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Text(
                      req.userName.isNotEmpty
                          ? req.userName[0].toUpperCase()
                          : 'O',
                    ),
                  ),
                  title: Text(
                    req.userName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(req.userEmail),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: DesignTokens.danger,
                          side: const BorderSide(color: DesignTokens.danger),
                          padding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spaceSm,
                          ),
                        ),
                        onPressed: () async {
                          final ok = await ref
                              .read(pendingRequestsProvider.notifier)
                              .reject(req.id);
                          if (ok && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  AppStrings.orgRequestRejectedToast,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(AppStrings.orgRequestsReject),
                      ),
                      const SizedBox(width: DesignTokens.spaceXs),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: DesignTokens.spaceSm,
                          ),
                        ),
                        onPressed: () async {
                          final ok = await ref
                              .read(pendingRequestsProvider.notifier)
                              .approve(req.id);
                          if (ok && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  AppStrings.orgRequestApprovedToast,
                                ),
                                backgroundColor: DesignTokens.neonGreen,
                              ),
                            );
                          }
                        },
                        child: const Text(AppStrings.orgRequestsApprove),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => Center(
            child: Text(
              'Error al cargar solicitudes',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
