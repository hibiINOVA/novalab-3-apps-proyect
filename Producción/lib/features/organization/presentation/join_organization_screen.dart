import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../../auth/auth_providers.dart';
import '../organization_providers.dart';

/// Pantalla para que el Operador ingrese el ID de la organización y mande la solicitud.
class JoinOrganizationScreen extends ConsumerStatefulWidget {
  const JoinOrganizationScreen({super.key});

  @override
  ConsumerState<JoinOrganizationScreen> createState() =>
      _JoinOrganizationScreenState();
}

class _JoinOrganizationScreenState
    extends ConsumerState<JoinOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final code = _codeController.text.trim().toUpperCase();
    final ok = await ref
        .read(organizationStatusProvider.notifier)
        .joinOrganization(code);

    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      context.go('/organization/pending');
    } else {
      setState(() {
        _error =
            'No se encontró la organización con ese ID. Verifica con tu Dueño.';
      });
    }
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.group_add_outlined,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: DesignTokens.spaceMd),
                      Text(
                        AppStrings.orgJoinTitle,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: DesignTokens.spaceSm),
                      Text(
                        AppStrings.orgJoinSubtitle,
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
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusSm,
                            ),
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
                        controller: _codeController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: AppStrings.orgJoinCodeLabel,
                          hintText: AppStrings.orgJoinCodeHint,
                          prefixIcon: Icon(Icons.tag),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty) return AppStrings.orgJoinCodeRequired;
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(AppStrings.orgJoinSubmit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
