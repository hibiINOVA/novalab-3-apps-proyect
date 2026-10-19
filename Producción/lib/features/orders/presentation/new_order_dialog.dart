import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/config/app_providers.dart';
import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../orders_providers.dart';

/// Diálogo interactivo para crear una nueva impresión / pedido (P-09).
///
/// Permite buscar cliente por ID o ingresar cliente nuevo con datos completos,
/// seleccionar productos del catálogo, cantidades, colores y enviar a la cola.
class NewOrderDialog extends ConsumerStatefulWidget {
  const NewOrderDialog({super.key});

  static Future<OrderDetail?> show(BuildContext context) {
    return showDialog<OrderDetail>(
      context: context,
      builder: (_) => const NewOrderDialog(),
    );
  }

  @override
  ConsumerState<NewOrderDialog> createState() => _NewOrderDialogState();
}

class _NewOrderDialogState extends ConsumerState<NewOrderDialog> {
  final _formKey = GlobalKey<FormState>();

  // Cliente por ID o nuevo
  final _customerIdSearchController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerNotesController = TextEditingController();
  Customer? _selectedCustomer;
  bool _searchingCustomer = false;
  String? _customerSearchError;

  // Pedido
  final _notesController = TextEditingController();
  DateTime? _promisedDate;
  bool _submitting = false;
  String? _submitError;

  // Items
  final List<_DraftItem> _items = <_DraftItem>[];

  @override
  void initState() {
    super.initState();
    // Añadir un item inicial por defecto
    _items.add(_DraftItem());
  }

  @override
  void dispose() {
    _customerIdSearchController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerEmailController.dispose();
    _customerNotesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _searchCustomerById() async {
    final query = _customerIdSearchController.text.trim();
    final id = int.tryParse(query);
    if (id == null) {
      setState(() {
        _customerSearchError = 'Ingresa un ID numérico válido.';
        _selectedCustomer = null;
      });
      return;
    }

    setState(() {
      _searchingCustomer = true;
      _customerSearchError = null;
    });

    try {
      final response = await ref
          .read(novalabApiProvider)
          .getCustomersApi()
          .getCustomer(customerId: id);
      final customer = response.data;
      if (!mounted) return;
      if (customer != null) {
        setState(() {
          _selectedCustomer = customer;
          _customerNameController.text = customer.name;
          _customerPhoneController.text = customer.phone ?? '';
          _customerEmailController.text = customer.email ?? '';
          _searchingCustomer = false;
        });
      } else {
        setState(() {
          _selectedCustomer = null;
          _customerSearchError = AppStrings.orderCustomerNotFound;
          _searchingCustomer = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _selectedCustomer = null;
        _customerSearchError = AppStrings.orderCustomerNotFound;
        _searchingCustomer = false;
      });
    }
  }

  void _clearCustomer() {
    setState(() {
      _selectedCustomer = null;
      _customerIdSearchController.clear();
      _customerNameController.clear();
      _customerPhoneController.clear();
      _customerEmailController.clear();
      _customerSearchError = null;
    });
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_items.isEmpty || _items.any((i) => i.productId == null)) {
      setState(() {
        _submitError = AppStrings.orderMustHaveItems;
      });
      return;
    }

    setState(() {
      _submitting = true;
      _submitError = null;
    });

    try {
      final itemsInput = _items.map((i) {
        return OrderItemInput(
          (b) => b
            ..productId = i.productId!
            ..quantity = i.quantity
            ..color = i.color.isEmpty ? null : i.color,
        );
      }).toList();

      final order = await ref
          .read(ordersListProvider.notifier)
          .createOrder(
            customerId: _selectedCustomer?.id,
            customerName: _selectedCustomer == null
                ? _customerNameController.text.trim()
                : null,
            customerPhone: _selectedCustomer == null
                ? _customerPhoneController.text.trim()
                : null,
            promisedDate: _promisedDate,
            notes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
            items: itemsInput,
          );

      if (!mounted) return;
      if (order != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(AppStrings.orderSuccess)));
        Navigator.of(context).pop(order);
      } else {
        setState(() {
          _submitting = false;
          _submitError = AppStrings.orderError;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _submitError = AppStrings.orderError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsCatalogProvider);

    return AlertDialog(
      title: const Row(
        children: <Widget>[
          Icon(Icons.print, color: DesignTokens.neonGreen),
          SizedBox(width: DesignTokens.spaceSm),
          Text(AppStrings.orderNew),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 580,
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

                // ─── Información del cliente ───────────────────────────────
                Text(
                  AppStrings.orderCustomer,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.neonGreen,
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _customerIdSearchController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppStrings.orderCustomerSearch,
                          hintText: 'Ej. 1',
                          prefixIcon: const Icon(Icons.badge_outlined),
                          suffixIcon: _searchingCustomer
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: _searchCustomerById,
                                ),
                        ),
                        onFieldSubmitted: (_) => _searchCustomerById(),
                      ),
                    ),
                    if (_selectedCustomer != null) ...<Widget>[
                      const SizedBox(width: DesignTokens.spaceSm),
                      OutlinedButton.icon(
                        onPressed: _clearCustomer,
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text('Limpiar'),
                      ),
                    ],
                  ],
                ),
                if (_customerSearchError != null) ...<Widget>[
                  const SizedBox(height: DesignTokens.spaceXs),
                  Text(
                    _customerSearchError!,
                    style: const TextStyle(
                      color: DesignTokens.danger,
                      fontSize: 12,
                    ),
                  ),
                ],
                if (_selectedCustomer != null) ...<Widget>[
                  const SizedBox(height: DesignTokens.spaceSm),
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spaceSm),
                    decoration: BoxDecoration(
                      color: DesignTokens.ecoGreenDim,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                      border: Border.all(
                        color: DesignTokens.neonGreen.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.check_circle,
                          color: DesignTokens.neonGreen,
                          size: 20,
                        ),
                        const SizedBox(width: DesignTokens.spaceSm),
                        Expanded(
                          child: Text(
                            'ID: ${_selectedCustomer!.id} · ${_selectedCustomer!.name} (${_selectedCustomer!.phone ?? 'Sin teléfono'})',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: DesignTokens.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...<Widget>[
                  const SizedBox(height: DesignTokens.spaceMd),
                  TextFormField(
                    controller: _customerNameController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.orderCustomerName,
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (val) {
                      if (_selectedCustomer == null &&
                          (val == null || val.trim().isEmpty)) {
                        return AppStrings.loginRequiredField;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _customerPhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: AppStrings.orderCustomerPhone,
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spaceSm),
                      Expanded(
                        child: TextFormField(
                          controller: _customerEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: AppStrings.orderCustomerEmail,
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: DesignTokens.spaceLg),
                const Divider(),
                const SizedBox(height: DesignTokens.spaceSm),

                // ─── Piezas / Items a imprimir ─────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Piezas a imprimir',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.neonGreen,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => _items.add(_DraftItem())),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text(AppStrings.orderAddItem),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),

                productsAsync.when(
                  data: (products) {
                    if (products.isEmpty) {
                      return const Text('No hay productos en catálogo.');
                    }
                    return Column(
                      children: <Widget>[
                        for (int i = 0; i < _items.length; i++)
                          _buildItemRow(i, products),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) =>
                      const Text('Error al cargar catálogo de productos.'),
                ),

                const SizedBox(height: DesignTokens.spaceMd),
                const Divider(),
                const SizedBox(height: DesignTokens.spaceSm),

                // ─── Entrega y notas ───────────────────────────────────────
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now.add(const Duration(days: 3)),
                            firstDate: now,
                            lastDate: now.add(const Duration(days: 365)),
                          );
                          if (picked != null) {
                            setState(() => _promisedDate = picked);
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                        ),
                        label: Text(
                          _promisedDate == null
                              ? AppStrings.orderPromisedDate
                              : '${_promisedDate!.day}/${_promisedDate!.month}/${_promisedDate!.year}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orderNotes,
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                  maxLines: 2,
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
              : const Text(AppStrings.orderSubmit),
        ),
      ],
    );
  }

  Widget _buildItemRow(int index, List<Product> products) {
    final item = _items[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
      child: Card(
        color: DesignTokens.navyCard,
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceSm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Selector de producto
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<int>(
                  initialValue: item.productId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orderProduct,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  items: products.map((p) {
                    return DropdownMenuItem<int>(
                      value: p.id,
                      child: Text(
                        '${p.name} (${p.material ?? 'PLA'}) - \$${p.basePrice.toStringAsFixed(0)}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      final prod = products.firstWhere((p) => p.id == val);
                      setState(() {
                        item.productId = val;
                        if (item.color.isEmpty && prod.color != null) {
                          item.color = prod.color!;
                        }
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: DesignTokens.spaceSm),

              // Color / Material
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: item.color,
                  decoration: const InputDecoration(
                    labelText: AppStrings.orderColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (val) => item.color = val.trim(),
                ),
              ),
              const SizedBox(width: DesignTokens.spaceSm),

              // Cantidad
              SizedBox(
                width: 70,
                child: TextFormField(
                  initialValue: item.quantity.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Cant.',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (val) {
                    final q = int.tryParse(val) ?? 1;
                    item.quantity = q < 1 ? 1 : q;
                  },
                ),
              ),

              if (_items.length > 1) ...<Widget>[
                IconButton(
                  tooltip: AppStrings.orderRemoveItem,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: DesignTokens.danger,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _items.removeAt(index)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DraftItem {
  int? productId;
  String color = '';
  int quantity = 1;
}
