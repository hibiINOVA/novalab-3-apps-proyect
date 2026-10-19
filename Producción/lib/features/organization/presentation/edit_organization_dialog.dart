import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../organization_providers.dart';

/// Ventana (solo Dueño) para editar los datos de la organización
/// (nombre, descripción, visión, misión) y subir/quitar el logo.
class EditOrganizationDialog extends ConsumerStatefulWidget {
  const EditOrganizationDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const EditOrganizationDialog(),
    );
  }

  @override
  ConsumerState<EditOrganizationDialog> createState() =>
      _EditOrganizationDialogState();
}

class _EditOrganizationDialogState
    extends ConsumerState<EditOrganizationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _visionController = TextEditingController();
  final _missionController = TextEditingController();
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _visionController.dispose();
    _missionController.dispose();
    super.dispose();
  }

  void _initFromStatus() {
    if (_initialized) return;
    final org = ref.read(organizationStatusProvider).value?.organization;
    if (org == null) return;
    _initialized = true;
    _nameController.text = org.name;
    _descriptionController.text = org.description ?? '';
    _visionController.text = org.vision ?? '';
    _missionController.text = org.mission ?? '';
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final org = await ref
        .read(organizationStatusProvider.notifier)
        .updateOrganization(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          vision: _visionController.text.trim(),
          mission: _missionController.text.trim(),
        );
    if (!mounted) return;
    setState(() => _saving = false);
    if (org != null) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.orgSaved),
          backgroundColor: DesignTokens.neonGreen,
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.orgErrorSave)));
    }
  }

  Future<void> _pickLogo() async {
    try {
      final picked = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['png', 'jpg', 'jpeg', 'webp'],
      );
      if (picked.isEmpty) return;
      final file = picked.single;
      final bytes = await file.readAsBytes();
      final name = file.name;
      final ok = await ref
          .read(organizationStatusProvider.notifier)
          .uploadLogo(bytes: bytes, filename: name);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok ? AppStrings.orgLogoUpdated : AppStrings.orgLogoError,
          ),
          backgroundColor: ok ? DesignTokens.neonGreen : null,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.orgLogoError)));
    }
  }

  Future<void> _removeLogo() async {
    final ok = await ref.read(organizationStatusProvider.notifier).deleteLogo();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? AppStrings.orgLogoRemoved : AppStrings.orgLogoError),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initFromStatus();
    final theme = Theme.of(context);
    final org = ref.watch(organizationStatusProvider).value?.organization;
    final hasLogo = org?.hasLogo == true;

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.edit_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: DesignTokens.spaceSm),
          const Text(AppStrings.orgEditTitle),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 460,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orgNameLabel,
                    prefixIcon: Icon(Icons.storefront_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return AppStrings.orgNameRequired;
                    if (v.length < 2) return AppStrings.orgNameTooShort;
                    return null;
                  },
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orgDescriptionLabel,
                    hintText: AppStrings.orgDescriptionHint,
                    prefixIcon: Icon(Icons.notes_outlined),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                TextFormField(
                  controller: _visionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orgVisionLabel,
                    hintText: AppStrings.orgVisionHint,
                    prefixIcon: Icon(Icons.visibility_outlined),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                TextFormField(
                  controller: _missionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orgMissionLabel,
                    hintText: AppStrings.orgMissionHint,
                    prefixIcon: Icon(Icons.flag_outlined),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceLg),
                Text(
                  AppStrings.orgUploadLogo,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: DesignTokens.spaceXs),
                if (hasLogo) ...<Widget>[
                  Container(
                    height: 96,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: ref
                        .watch(organizationLogoProvider)
                        .when(
                          data: (bytes) => bytes == null
                              ? const SizedBox.shrink()
                              : Image.memory(bytes, fit: BoxFit.contain),
                          loading: () =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          error: (_, _) =>
                              const Icon(Icons.broken_image_outlined),
                        ),
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                ],
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickLogo,
                        icon: const Icon(Icons.upload_file_outlined),
                        label: const Text(AppStrings.orgUploadLogo),
                      ),
                    ),
                    if (hasLogo) ...<Widget>[
                      const SizedBox(width: DesignTokens.spaceSm),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: DesignTokens.danger,
                          side: const BorderSide(color: DesignTokens.danger),
                        ),
                        onPressed: _removeLogo,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text(AppStrings.orgRemoveLogo),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceXs),
                Text(
                  AppStrings.orgLogoHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
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
