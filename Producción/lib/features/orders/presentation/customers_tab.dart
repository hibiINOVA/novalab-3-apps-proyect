import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../orders_providers.dart';
import 'customer_form_dialog.dart';

/// Tab de clientes: listado, creación y detalle básico.
///
/// Multi-tenant: los clientes se filtran por la organización activa del
/// usuario JWT (el backend aplica el filtro automáticamente).
class CustomersTab extends ConsumerWidget {
  const CustomersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersListProvider);

    return Column(
      children: <Widget>[
        Padding(
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
                  AppStrings.customersTitle,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.neonGreen,
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spaceMd),
              FilledButton.tonalIcon(
                onPressed: () async {
                  final customer = await CustomerFormDialog.show(context);
                  if (customer != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppStrings.customerCreated)),
                    );
                  }
                },
                icon: const Icon(Icons.person_add, size: 18),
                label: const Text(AppStrings.customerAdd),
              ),
            ],
          ),
        ),
        Expanded(
          child: customers.when(
            data: (list) => list.isEmpty
                ? const _CenteredMessage(
                    text: AppStrings.customersEmpty,
                    icon: Icons.people_outline,
                  )
                : _CustomersList(customers: list),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) =>
                _ErrorState(onRetry: () => ref.refresh(customersListProvider)),
          ),
        ),
      ],
    );
  }
}

class _CustomersList extends StatelessWidget {
  const _CustomersList({required this.customers});

  final List<Customer> customers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final customer in customers) ...<Widget>[
            Card(
              color: DesignTokens.navyCard,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: DesignTokens.neonGreen,
                  child: Icon(Icons.person, color: DesignTokens.midnightBlue),
                ),
                title: Text(
                  customer.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: DesignTokens.white,
                  ),
                ),
                subtitle: Text(
                  '${customer.phone ?? '-'} · ${customer.email ?? '-'}',
                  style: const TextStyle(color: DesignTokens.white),
                ),
                trailing: customer.notes != null && customer.notes!.isNotEmpty
                    ? const Icon(Icons.note_outlined, size: 18)
                    : null,
              ),
            ),
            const SizedBox(height: DesignTokens.spaceSm),
          ],
        ],
      ),
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
            AppStrings.customersLoadError,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          FilledButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
        ],
      ),
    );
  }
}
