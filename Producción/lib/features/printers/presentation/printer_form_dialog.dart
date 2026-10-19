import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/config/app_providers.dart';
import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../printers_providers.dart';

/// Modelos de impresora más conocidos; el campo también acepta texto libre.
const List<String> kPrinterModels = <String>[
  'Prusa MK4',
  'Prusa MK3S+',
  'Prusa Mini+',
  'Prusa XL',
  'Creality Ender 3',
  'Creality Ender 3 V3',
  'Creality K1 Max',
  'Bambu Lab A1',
  'Bambu Lab P1S',
  'Bambu Lab X1C',
  'Anycubic Kobra 2 Pro',
  'Sovol SV06',
  'Artillery Sidewinder X4',
];

/// Diálogo para crear o editar una impresora (P-02 CRUD completo).
class PrinterFormDialog extends ConsumerStatefulWidget {
  const PrinterFormDialog({super.key, this.printer});

  final Printer? printer;

  static Future<bool?> show(BuildContext context, {Printer? printer}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => PrinterFormDialog(printer: printer),
    );
  }

  @override
  ConsumerState<PrinterFormDialog> createState() => _PrinterFormDialogState();
}

class _PrinterFormDialogState extends ConsumerState<PrinterFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _urlController;
  late final TextEditingController _keyController;
  late final TextEditingController _widthController;
  late final TextEditingController _depthController;
  late final TextEditingController _camerasController;
  late bool _cameraAvailable;
  bool _saving = false;
  bool _testing = false;
  String? _error;
  String? _testResult;
  TextEditingController? _modelField;

  @override
  void initState() {
    super.initState();
    final p = widget.printer;
    _nameController = TextEditingController(text: p?.name ?? '');
    _urlController = TextEditingController();
    _keyController = TextEditingController();
    _widthController = TextEditingController(text: '220');
    _depthController = TextEditingController(text: '220');
    _camerasController = TextEditingController(
      text: (p?.cameras ?? const <String>[]).join('\n'),
    );
    _cameraAvailable = p?.cameraAvailable ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _keyController.dispose();
    _widthController.dispose();
    _depthController.dispose();
    _camerasController.dispose();
    super.dispose();
  }

  List<String> _parseCameras() => _camerasController.text
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  /// BE-01 (P-13): prueba URL + API key sin guardar.
  Future<void> _testConnection() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() => _testResult = AppStrings.printerTestConnectionIdle);
      return;
    }
    setState(() {
      _testing = true;
      _testResult = null;
    });
    try {
      final response = await ref
          .read(novalabApiProvider)
          .getPrintersApi()
          .testPrinterConnection(
            printerConnectionTestRequest: PrinterConnectionTestRequest(
              (b) => b
                ..octoprintUrl = url
                ..apiKey = _keyController.text.trim().isEmpty
                    ? null
                    : _keyController.text.trim(),
            ),
          );
      final result = response.data;
      setState(() {
        _testResult =
            result?.message ??
            (result?.ok ?? false
                ? AppStrings.printerTestConnectionOk
                : AppStrings.printerErrorSave);
      });
    } catch (_) {
      setState(() => _testResult = AppStrings.printerErrorSave);
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final name = _nameController.text.trim();
      final model = _modelField?.text.trim();
      final url = _urlController.text.trim().isEmpty
          ? null
          : _urlController.text.trim();
      final key = _keyController.text.trim().isEmpty
          ? null
          : _keyController.text.trim();
      final width = double.tryParse(_widthController.text.trim());
      final depth = double.tryParse(_depthController.text.trim());
      final cameras = _parseCameras();

      final controller = ref.read(printersProvider.notifier);
      if (widget.printer != null) {
        await controller.updatePrinter(
          id: widget.printer!.id,
          name: name,
          model: (model == null || model.isEmpty) ? null : model,
          octoprintUrl: url,
          apiKey: key,
          bedWidth: width,
          bedDepth: depth,
          cameraAvailable: _cameraAvailable,
          cameras: cameras,
        );
      } else {
        await controller.createPrinter(
          name: name,
          model: (model == null || model.isEmpty) ? null : model,
          octoprintUrl: url,
          apiKey: key,
          bedWidth: width,
          bedDepth: depth,
          cameraAvailable: _cameraAvailable,
          cameras: cameras,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.printerSaved)));
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = AppStrings.printerErrorSave;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.printer != null;

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(
            isEditing ? Icons.edit_note : Icons.add_circle_outline,
            color: DesignTokens.neonGreen,
          ),
          const SizedBox(width: DesignTokens.spaceSm),
          Text(isEditing ? AppStrings.printerEdit : AppStrings.printerAdd),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_error != null) ...<Widget>[
                  Text(
                    _error!,
                    style: const TextStyle(color: DesignTokens.danger),
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                ],
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.printerNameLabel,
                    hintText: AppStrings.printerNameHint,
                    prefixIcon: Icon(Icons.print_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.loginRequiredField;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                Autocomplete<String>(
                  initialValue: TextEditingValue(
                    text: widget.printer?.model ?? '',
                  ),
                  optionsBuilder: (editing) {
                    final query = editing.text.trim().toLowerCase();
                    if (query.isEmpty) return kPrinterModels;
                    return kPrinterModels.where(
                      (m) => m.toLowerCase().contains(query),
                    );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                        _modelField = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: AppStrings.printerModelLabel,
                            hintText: AppStrings.printerModelHint,
                            helperText: AppStrings.printerModelHelper,
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                        );
                      },
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.printerOctoprintUrl,
                    prefixIcon: Icon(Icons.link_outlined),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                TextFormField(
                  controller: _keyController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: AppStrings.printerApiKey,
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                // BE-01 / P-13: probar conexión sin guardar.
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _testing ? null : _testConnection,
                    icon: _testing
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.wifi_tethering_outlined),
                    label: const Text(AppStrings.printerTestConnection),
                  ),
                ),
                if (_testResult != null) ...<Widget>[
                  Text(
                    _testResult!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                ],
                const SizedBox(height: DesignTokens.spaceMd),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _widthController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Ancho (mm)',
                          prefixIcon: Icon(Icons.straighten),
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceSm),
                    Expanded(
                      child: TextFormField(
                        controller: _depthController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Profundidad (mm)',
                          prefixIcon: Icon(Icons.square_foot),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                TextFormField(
                  controller: _camerasController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: AppStrings.printerCamerasLabel,
                    hintText: AppStrings.printerCamerasHint,
                    helperText: AppStrings.printerCamerasHelper,
                    prefixIcon: Icon(Icons.videocam_outlined),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                SwitchListTile(
                  title: const Text(AppStrings.printerCameraHas),
                  value: _cameraAvailable,
                  activeThumbColor: DesignTokens.neonGreen,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setState(() => _cameraAvailable = val),
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
          onPressed: _saving ? null : _submit,
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
