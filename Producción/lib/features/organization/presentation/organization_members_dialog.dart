import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../organization_providers.dart';

/// Ventana (solo Dueño) con los miembros activos de la organización.
class OrganizationMembersDialog extends ConsumerWidget {
  const OrganizationMembersDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const OrganizationMembersDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(organizationMembersProvider);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.groups_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: DesignTokens.spaceSm),
          const Text(AppStrings.orgMembersTitle),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: membersAsync.when(
          data: (members) {
            if (members.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spaceLg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.person_off_outlined,
                      size: 40,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      AppStrings.orgMembersEmpty,
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
              itemCount: members.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final member = members[index];
                final isOwner = member.role == Role.owner;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: isOwner
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    child: Text(
                      member.userName.isNotEmpty
                          ? member.userName[0].toUpperCase()
                          : 'O',
                    ),
                  ),
                  title: Text(
                    member.userName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(member.userEmail),
                  trailing: Chip(
                    label: Text(
                      isOwner
                          ? AppStrings.orgMemberRoleOwner
                          : AppStrings.orgMemberRoleOperator,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isOwner
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    backgroundColor: isOwner
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    visualDensity: VisualDensity.compact,
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
              AppStrings.orgMembersLoadError,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.close),
        ),
      ],
    );
  }
}
