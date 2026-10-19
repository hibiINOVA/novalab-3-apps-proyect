import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../../core/realtime/realtime_message.dart';
import '../../core/realtime/realtime_providers.dart';

/// Catálogo de productos disponibles para imprimir.
final productsCatalogProvider = FutureProvider<List<Product>>((ref) async {
  final response = await ref
      .read(novalabApiProvider)
      .getProductsApi()
      .listProducts();
  return response.data?.toList() ?? <Product>[];
});

/// Catálogo de clientes existentes.
final customersListProvider = FutureProvider<List<Customer>>((ref) async {
  final response = await ref
      .read(novalabApiProvider)
      .getCustomersApi()
      .listCustomers();
  return response.data?.toList() ?? <Customer>[];
});

/// Búsqueda o consulta de cliente individual por ID.
final customerByIdProvider = FutureProvider.family<Customer?, int>((
  ref,
  customerId,
) async {
  try {
    final response = await ref
        .read(novalabApiProvider)
        .getCustomersApi()
        .getCustomer(customerId: customerId);
    return response.data;
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) return null;
    rethrow;
  }
});

/// Lista de pedidos con auto-actualización por WebSocket.
final ordersListProvider =
    AsyncNotifierProvider<OrdersListController, List<OrderSummary>>(
      OrdersListController.new,
    );

class OrdersListController extends AsyncNotifier<List<OrderSummary>> {
  StreamSubscription<RealtimeMessage>? _subscription;

  @override
  Future<List<OrderSummary>> build() async {
    final client = ref.watch(realtimeClientProvider);
    _subscription = client.messages.listen(_onRealtimeMessage);
    ref.onDispose(() => _subscription?.cancel());
    return _fetchOrders();
  }

  Future<List<OrderSummary>> _fetchOrders() async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrdersApi()
        .listOrders();
    return response.data?.toList() ?? <OrderSummary>[];
  }

  Future<void> _onRealtimeMessage(RealtimeMessage message) async {
    if (message.entity != 'order') return;
    try {
      state = AsyncData(await _fetchOrders());
    } catch (_) {
      // Ignorar fallo puntual de red
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchOrders);
  }

  /// Crea un nuevo pedido / manda impresión (P-09).
  Future<OrderDetail?> createOrder({
    int? customerId,
    String? customerName,
    String? customerPhone,
    DateTime? promisedDate,
    String? notes,
    double? total,
    required List<OrderItemInput> items,
  }) async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrdersApi()
        .createOrder(
          orderCreateRequest: OrderCreateRequest(
            (b) => b
              ..customerId = customerId
              ..customerName = customerName
              ..customerPhone = customerPhone
              ..promisedDate = promisedDate?.toDate()
              ..notes = notes
              ..total = total
              ..items.addAll(items),
          ),
        );
    final order = response.data;
    if (order != null) {
      ref.invalidateSelf();
    }
    return order;
  }

  /// Cambia el estado manual de un pedido.
  Future<OrderDetail?> updateOrderStatus(
    int orderId,
    OrderStatus status,
  ) async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrdersApi()
        .updateOrderStatus(
          orderId: orderId,
          orderStatusUpdateRequest: OrderStatusUpdateRequest(
            (b) => b..status = status,
          ),
        );
    final order = response.data;
    if (order != null) {
      ref.invalidateSelf();
    }
    return order;
  }
}
