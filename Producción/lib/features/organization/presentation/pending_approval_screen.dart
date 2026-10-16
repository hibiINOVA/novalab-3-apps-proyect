import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../../auth/auth_providers.dart';
import '../organization_providers.dart';

/// Pantalla donde el Operador espera a que el Dueño acepte su solicitud.
class PendingApprovalScreen extends ConsumerStatefulWidget {
  const PendingApprovalScreen({super.key});

  @override
  ConsumerState<PendingApprovalScreen> createState() =>
      _PendingApprovalScreenState();
}

class _PendingApprovalScreenState extends ConsumerState<PendingApprovalScreen> {
  bool _checking = false;

  Future<void> _checkStatus() async {
    setState(() => _checking = true);
    await ref.read(organizationStatusProvider.notifier).refresh();
    if (!mounted) return;
    setState(() => _checking = false);

    final status = ref.read(organizationStatusProvider).value?.membershipStatus;
    if (status == MembershipStatus.active) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.orgPendingApproved),
          backgroundColor: DesignTokens.neonGreen,
        ),
      );
      context.go('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.orgPendingStillWaiting),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orgStatus = ref.watch(organizationStatusProvider).value;
    final orgName = orgStatus?.organization?.name;
    final orgCode = orgStatus?.organization?.code;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text(AppStrings.logout),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.spaceLg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spaceXl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.hourglass_top_rounded,
                      size: 56,
                      color: DesignTokens.warning,
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                    Text(
                      AppStrings.orgPendingTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      AppStrings.orgPendingMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: DesignTokens.spaceLg),
                    if (orgName != null || orgCode != null) ...<Widget>[
                      Container(
                        padding: const EdgeInsets.all(DesignTokens.spaceMd),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusMd,
                          ),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              AppStrings.orgPendingOrgLabel,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: DesignTokens.spaceXs),
                            if (orgName != null)
                              Text(
                                orgName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            if (orgCode != null)
                              Text(
                                orgCode,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spaceXl),
                    ],
                    FilledButton.icon(
                      onPressed: _checking ? null : _checkStatus,
                      icon: _checking
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.refresh),
                      label: const Text(AppStrings.orgPendingCheckStatus),
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    OutlinedButton(
                      onPressed: () =>
                          ref.read(authControllerProvider.notifier).signOut(),
                      child: const Text(AppStrings.logout),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
