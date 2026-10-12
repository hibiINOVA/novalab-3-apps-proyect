import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for OrdersApi
void main() {
  final instance = NovalabApi().getOrdersApi();

  group(OrdersApi, () {
    // Crea un pedido nuevo (P-09)
    //
    //Future<OrderDetail> createOrder(OrderCreateRequest orderCreateRequest) async
    test('test createOrder', () async {
      // TODO
    });

    // Detalle de pedido (items, faltantes, historial, envío)
    //
    //Future<OrderDetail> getOrder(int orderId) async
    test('test getOrder', () async {
      // TODO
    });

    // Lista pedidos con filtros y búsqueda por folio/cliente
    //
    //Future<BuiltList<OrderSummary>> listOrders({ OrderStatus status, int customerId, Date dueBefore, String q }) async
    test('test listOrders', () async {
      // TODO
    });

    // Cambio manual de estado (Empacado, Enviado, Entregado, Cancelado)
    //
    //Future<OrderDetail> updateOrderStatus(int orderId, OrderStatusUpdateRequest orderStatusUpdateRequest) async
    test('test updateOrderStatus', () async {
      // TODO
    });
  });
}
