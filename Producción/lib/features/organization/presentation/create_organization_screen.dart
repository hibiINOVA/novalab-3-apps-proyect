import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../../auth/auth_providers.dart';
import '../organization_providers.dart';

/// Pantalla para que el Dueño cree su organización al iniciar por primera vez.
class CreateOrganizationScreen extends ConsumerStatefulWidget {
  const CreateOrganizationScreen({super.key});

  @override
  ConsumerState<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState
    extends ConsumerState<CreateOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _loading = false;
  String? _error;
  Organization? _createdOrg;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final name = _nameController.text.trim();
      final org = await ref
          .read(organizationStatusProvider.notifier)
          .createOrganization(name);

      if (!mounted) return;
      if (org != null) {
        setState(() {
          _loading = false;
          _createdOrg = org;
        });
      } else {
        setState(() {
          _loading = false;
          _error = 'No se pudo crear la organización. Intenta con otro nombre.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Error al crear la organización. Intenta de nuevo.';
      });
    }
  }

  void _copyId(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.orgCopied),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                child: _createdOrg != null
                    ? _buildSuccessView(context, _createdOrg!)
                    : _buildFormView(context, theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormView(BuildContext context, ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.business_outlined,
            size: 48,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          Text(
            AppStrings.orgCreateTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            AppStrings.orgCreateSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.spaceXl),
          if (_error != null) ...<Widget>[
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceSm),
              decoration: BoxDecoration(
                color: DesignTokens.danger.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: DesignTokens.danger,
                    size: 20,
                  ),
                  const SizedBox(width: DesignTokens.spaceSm),
                  Expanded(
                    child: Text(
                      _error!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: DesignTokens.danger,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceMd),
          ],
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: AppStrings.orgNameLabel,
              hintText: AppStrings.orgNameHint,
              prefixIcon: Icon(Icons.storefront_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final v = value?.trim() ?? '';
              if (v.isEmpty) return AppStrings.orgNameRequired;
              if (v.length < 2) return AppStrings.orgNameTooShort;
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: DesignTokens.spaceLg),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(AppStrings.orgCreateSubmit),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context, Organization org) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.check_circle_outline,
          size: 56,
          color: DesignTokens.neonGreen,
        ),
        const SizedBox(height: DesignTokens.spaceMd),
        Text(
          AppStrings.orgCreatedSuccess,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        Text(
          org.name,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DesignTokens.spaceLg),
        Text(
          AppStrings.orgIdCopyHint,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spaceMd,
            vertical: DesignTokens.spaceSm,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SelectableText(
                org.code,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: DesignTokens.spaceMd),
              IconButton(
                tooltip: AppStrings.orgCopyId,
                icon: const Icon(Icons.copy),
                onPressed: () => _copyId(org.code),
              ),
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spaceXl),
        FilledButton.icon(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_forward),
          label: const Text(AppStrings.orgGoToDashboard),
        ),
      ],
    );
  }
}
