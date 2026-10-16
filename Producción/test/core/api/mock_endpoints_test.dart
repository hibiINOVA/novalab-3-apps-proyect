import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/api/api_client_factory.dart';
import 'package:produccion/core/config/app_config.dart';

void main() {
  late NovalabApi api;

  setUp(() {
    final factory = ApiClientFactory(
      const AppConfig(apiBaseUrl: 'http://localhost:8081', useMocks: true),
    );
    api = factory.create();
  });

  group('registro de cuenta', () {
    test('crea la cuenta y devuelve sesión; correo repetido da 409', () async {
      final created = await api.getAuthApi().register(
        registerRequest: RegisterRequest(
          (b) => b
            ..name = 'Nueva Cuenta'
            ..email = 'nueva@ejemplo.mx'
            ..password = 'secreta123'
            ..role = Role.operator_,
        ),
      );
      expect(created.statusCode, 201);
      expect(created.data!.user.email, 'nueva@ejemplo.mx');
      expect(created.data!.user.role, Role.operator_);
      expect(created.data!.accessToken, isNotEmpty);

      // Segunda vez con el mismo correo → 409.
      try {
        await api.getAuthApi().register(
          registerRequest: RegisterRequest(
            (b) => b
              ..name = 'Duplicada'
              ..email = 'nueva@ejemplo.mx'
              ..password = 'secreta123'
              ..role = Role.owner,
          ),
        );
        fail('Se esperaba un 409 por correo duplicado');
      } on DioException catch (error) {
        expect(error.response?.statusCode, 409);
      }
    });
  });

  group('P-04 sugerencia', () {
    test('propone asignación con explicación y la acepta', () async {
      final suggestion = await api.getQueueApi().suggestQueueAssignment();
      expect(suggestion.statusCode, 200);
      expect(suggestion.data!.assignments, isNotEmpty);
      expect(suggestion.data!.assignments.first.explanation, isNotEmpty);

      final queue = await api.getQueueApi().acceptQueueAssignment(
        queueAcceptRequest: QueueAcceptRequest(
          (b) => b
            ..version = suggestion.data!.version
            ..assignments.addAll(
              suggestion.data!.assignments.map(
                (a) => QueueAcceptEntry(
                  (e) => e
                    ..itemId = a.itemId
                    ..printerId = a.printerId,
                ),
              ),
            ),
        ),
      );

      expect(queue.statusCode, 200);
      expect(queue.data!.unassigned, isEmpty);
    });
  });

  group('P-05 / P-06 print jobs', () {
    test('iniciar, completar y descartar el job de un item', () async {
      final started = await api.getPrintJobsApi().startPrintJob(
        printJobStartRequest: PrintJobStartRequest(
          (b) => b
            ..itemId = 5
            ..printerId = 2,
        ),
      );
      expect(started.statusCode, 201);
      expect(started.data!.state, ItemState.printing);

      final completed = await api.getPrintJobsApi().completePrintJob(
        jobId: started.data!.id,
      );
      expect(completed.data!.state, ItemState.printed);
    });

    test('fallar registra motivo y reimprimir crea un job nuevo', () async {
      final started = await api.getPrintJobsApi().startPrintJob(
        printJobStartRequest: PrintJobStartRequest(
          (b) => b
            ..itemId = 6
            ..printerId = 2,
        ),
      );

      final failed = await api.getPrintJobsApi().failPrintJob(
        jobId: started.data!.id,
        printJobFailRequest: PrintJobFailRequest(
          (b) => b..reason = 'Se soltó la cama',
        ),
      );
      expect(failed.data!.state, ItemState.failed);
      expect(failed.data!.failureReason, 'Se soltó la cama');

      final reprint = await api.getPrintJobsApi().reprintJob(
        jobId: started.data!.id,
      );
      expect(reprint.statusCode, 201);
      expect(reprint.data!.id, isNot(started.data!.id));
      expect(reprint.data!.state, ItemState.queued);
    });
  });

  group('P-07 / P-08 pedidos', () {
    test('lista con filtros, búsqueda y alertas de vencimiento', () async {
      final all = await api.getOrdersApi().listOrders();
      expect(all.data, hasLength(5));

      final queued = await api.getOrdersApi().listOrders(
        status: OrderStatus.queued,
      );
      expect(
        queued.data!.map((o) => o.folio),
        containsAll(<String>['NL-1002', 'NL-1003']),
      );

      final byFolio = await api.getOrdersApi().listOrders(q: 'NL-1001');
      expect(byFolio.data, hasLength(1));
      expect(byFolio.data!.first.dueState, DueState.ok);

      final overdue = all.data!.where((o) => o.dueState == DueState.overdue);
      expect(overdue.map((o) => o.folio), contains('NL-1003'));
    });

    test('detalle incluye faltantes e historial', () async {
      final detail = await api.getOrdersApi().getOrder(orderId: 1001);
      expect(detail.data!.trackingToken, isNotEmpty);
      expect(detail.data!.items, hasLength(1));
      expect(detail.data!.items.first.missingQuantity, 3);
      expect(detail.data!.history, hasLength(3));
    });

    test('cambio manual de estado se agrega al historial', () async {
      final before = await api.getOrdersApi().getOrder(orderId: 1004);
      final updated = await api.getOrdersApi().updateOrderStatus(
        orderId: 1004,
        orderStatusUpdateRequest: OrderStatusUpdateRequest(
          (b) => b..status = OrderStatus.packed,
        ),
      );
      expect(updated.data!.status, OrderStatus.packed);
      expect(updated.data!.history, hasLength(before.data!.history.length + 1));
    });
  });

  group('P-09 nuevo pedido', () {
    test('catálogos de clientes y productos', () async {
      final customers = await api.getCustomersApi().listCustomers();
      final products = await api.getProductsApi().listProducts();
      expect(customers.data, hasLength(5));
      expect(products.data, hasLength(5));
    });

    test('crea un pedido con cliente nuevo y calcula el total', () async {
      final created = await api.getOrdersApi().createOrder(
        orderCreateRequest: OrderCreateRequest(
          (b) => b
            ..customerName = 'Nuevo Cliente'
            ..customerPhone = '555-0199'
            ..items = ListBuilder(<OrderItemInput>[
              OrderItemInput(
                (i) => i
                  ..productId = 1
                  ..quantity = 2,
              ),
            ]),
        ),
      );

      expect(created.statusCode, 201);
      expect(created.data!.status, OrderStatus.confirmed);
      expect(created.data!.itemsCount, 2);
      expect(created.data!.total, 500);
      expect(created.data!.trackingToken, isNotEmpty);

      final search = await api.getOrdersApi().listOrders(q: 'Nuevo Cliente');
      expect(search.data!.map((o) => o.folio), contains(created.data!.folio));
    });
  });

  group('Organizaciones e invitaciones de operadores', () {
    test('Dueño crea organización con nombre único y recibe ID', () async {
      final res = await api.getOrganizationsApi().createOrganization(
        organizationCreateRequest: OrganizationCreateRequest(
          (b) => b..name = 'Taller Alfa 3D',
        ),
      );
      expect(res.statusCode, 201);
      expect(res.data!.name, 'Taller Alfa 3D');
      expect(res.data!.code, startsWith('ORG-'));

      try {
        await api.getOrganizationsApi().createOrganization(
          organizationCreateRequest: OrganizationCreateRequest(
            (b) => b..name = 'Taller Alfa 3D',
          ),
        );
        fail('Se esperaba error por nombre duplicado');
      } on DioException catch (e) {
        expect(e.response?.statusCode, 400);
      }
    });

    test('Operador se une con ID de organización y dueño lo acepta', () async {
      final orgRes = await api.getOrganizationsApi().createOrganization(
        organizationCreateRequest: OrganizationCreateRequest(
          (b) => b..name = 'Laboratorio Beta',
        ),
      );
      final orgCode = orgRes.data!.code;

      final joinRes = await api.getOrganizationsApi().joinOrganization(
        joinOrganizationRequest: JoinOrganizationRequest(
          (b) => b..organizationCode = orgCode,
        ),
      );
      expect(joinRes.statusCode, 200);
      expect(joinRes.data!.membershipStatus, MembershipStatus.pending);

      final requests = await api
          .getOrganizationsApi()
          .listOrganizationRequests();
      expect(requests.statusCode, 200);
      expect(requests.data, isNotEmpty);
      final req = requests.data!.firstWhere(
        (r) => r.organizationCode == orgCode,
      );
      expect(req.status, MembershipStatus.pending);

      final approveRes = await api
          .getOrganizationsApi()
          .approveOrganizationRequest(requestId: req.id);
      expect(approveRes.statusCode, 200);
      expect(approveRes.data!.status, MembershipStatus.active);
    });
  });
}
