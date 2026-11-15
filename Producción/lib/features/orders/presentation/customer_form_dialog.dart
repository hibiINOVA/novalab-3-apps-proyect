import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../orders_providers.dart';

/// Diálogo para crear un nuevo cliente (CRUD de clientes).
class CustomerFormDialog extends ConsumerStatefulWidget {
  const CustomerFormDialog({super.key});

  static Future<Customer?> show(BuildContext context) {
    return showDialog<Customer>(
      context: context,
      builder: (_) => const CustomerFormDialog(),
    );
  }

  @override
  ConsumerState<CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends ConsumerState<CustomerFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  bool _submitting = false;
  String? _submitError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _submitting = true;
      _submitError = null;
    });

    try {
      final customer = await ref.read(
        customerCreateProvider(
          CustomerCreateRequest(
            (b) => b
              ..name = _nameController.text.trim()
              ..phone = _phoneController.text.trim().isEmpty
                  ? null
                  : _phoneController.text.trim()
              ..email = _emailController.text.trim().isEmpty
                  ? null
                  : _emailController.text.trim()
              ..notes = _notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim(),
          ),
        ).future,
      );

      if (!mounted) return;
      Navigator.of(context).pop(customer);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _submitError = AppStrings.customerCreateError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: <Widget>[
          Icon(Icons.person_add, color: DesignTokens.neonGreen),
          SizedBox(width: DesignTokens.spaceSm),
          Text(AppStrings.customerAdd),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 480,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (_submitError != null) ...<Widget>[
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spaceSm),
                    decoration: BoxDecoration(
                      color: DesignTokens.danger.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: Text(
                      _submitError!,
                      style: const TextStyle(color: DesignTokens.danger),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                ],

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppStrings.customerNameLabel,
                    hintText: AppStrings.customerNameHint,
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return AppStrings.customerNameRequired;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: AppStrings.customerPhoneLabel,
                          hintText: AppStrings.customerPhoneHint,
                          prefixIcon: const Icon(Icons.phone_outlined),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceSm),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: AppStrings.customerEmailLabel,
                          hintText: AppStrings.customerEmailHint,
                          prefixIcon: const Icon(Icons.alternate_email),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: AppStrings.customerNotesLabel,
                    hintText: AppStrings.customerNotesHint,
                    prefixIcon: const Icon(Icons.notes_outlined),
                  ),
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text(AppStrings.save),
        ),
      ],
    );
  }
}
