import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../auth_providers.dart';
import '../auth_state.dart';

/// Pantalla de creación de cuenta (registro abierto, decisión v1).
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  Role _role = Role.operator_;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(authControllerProvider.notifier)
        .signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          role: _role,
        );
    // Si el registro falló el estado sigue unauthenticated y el mensaje se
    // muestra en build; si tuvo éxito el router redirige al tablero.
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      authControllerProvider.select((state) => state.status),
    );
    final errorMessage = ref.watch(
      authControllerProvider.select((state) => state.errorMessage),
    );
    final isSubmitting = status == AuthStatus.authenticating;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.spaceLg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    AppStrings.registerTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceXs),
                  Text(
                    AppStrings.registerSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: DesignTokens.spaceXl),
                  TextFormField(
                    controller: _nameController,
                    enabled: !isSubmitting,
                    decoration: const InputDecoration(
                      labelText: AppStrings.registerName,
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return AppStrings.registerNameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const <String>[AutofillHints.email],
                    enabled: !isSubmitting,
                    decoration: const InputDecoration(
                      labelText: AppStrings.loginEmail,
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return AppStrings.loginRequiredField;
                      }
                      if (!text.contains('@')) {
                        return AppStrings.loginInvalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      labelText: AppStrings.loginPassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? AppStrings.loginShowPassword
                            : AppStrings.loginHidePassword,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    validator: (value) {
                      final text = value ?? '';
                      if (text.isEmpty) {
                        return AppStrings.loginRequiredField;
                      }
                      if (text.length < 8) {
                        return AppStrings.registerPasswordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: _obscurePassword,
                    enabled: !isSubmitting,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      labelText: AppStrings.registerPasswordConfirm,
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return AppStrings.registerPasswordMismatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  DropdownButtonFormField<Role>(
                    initialValue: _role,
                    decoration: const InputDecoration(
                      labelText: AppStrings.registerRole,
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    items: const <DropdownMenuItem<Role>>[
                      DropdownMenuItem<Role>(
                        value: Role.owner,
                        child: Text(AppStrings.registerRoleOwner),
                      ),
                      DropdownMenuItem<Role>(
                        value: Role.operator_,
                        child: Text(AppStrings.registerRoleOperator),
                      ),
                    ],
                    onChanged: isSubmitting
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _role = value);
                            }
                          },
                  ),
                  const SizedBox(height: DesignTokens.spaceLg),
                  if (errorMessage != null) ...<Widget>[
                    Text(
                      errorMessage,
                      key: const Key('register-error'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                  ],
                  FilledButton(
                    onPressed: isSubmitting ? null : _submit,
                    child: isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(AppStrings.registerSubmit),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  TextButton(
                    onPressed: isSubmitting ? null : () => context.go('/login'),
                    child: const Text(AppStrings.registerGoToLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
