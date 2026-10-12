import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/api/api_client_factory.dart';
import 'package:produccion/core/api/mock/mock_backend.dart';
import 'package:produccion/core/config/app_config.dart';

void main() {
  late NovalabApi api;

  setUp(() {
    final factory = ApiClientFactory(
      const AppConfig(apiBaseUrl: 'http://localhost:8081', useMocks: true),
    );
    api = factory.create();
  });

  test('login correcto devuelve token y usuario owner', () async {
    final response = await api.getAuthApi().login(
      loginRequest: LoginRequest(
        (b) => b
          ..email = kMockOwnerEmail
          ..password = kMockPassword,
      ),
    );

    expect(response.statusCode, 200);
    expect(response.data!.accessToken, isNotEmpty);
    expect(response.data!.user.role, Role.owner);
  });

  test('login con contraseña incorrecta lanza 401', () async {
    expect(
      () => api.getAuthApi().login(
        loginRequest: LoginRequest(
          (b) => b
            ..email = kMockOwnerEmail
            ..password = 'incorrecta',
        ),
      ),
      throwsA(
        isA<Object>().having(
          (e) => (e as dynamic).response?.statusCode,
          'statusCode',
          401,
        ),
      ),
    );
  });

  test('branding expone la marca del negocio', () async {
    final response = await api.getPublicApi().getBranding();

    expect(response.data!.businessName, 'NOVALAB');
    expect(response.data!.accentColor, '#00FF87');
  });

  test('lista de impresoras conserva el estado en vivo', () async {
    final response = await api.getPrintersApi().listPrinters();

    expect(response.data, hasLength(3));
    expect(response.data!.first.state, PrinterState.printing);
    expect(response.data!.last.state, PrinterState.offline);
  });

  test('reordenar la cola mueve un item a otra impresora', () async {
    final before = await api.getQueueApi().getQueue();
    expect(before.data!.byPrinter['2'], hasLength(2));

    final item = before.data!.unassigned.first;

    final after = await api.getQueueApi().reorderQueue(
      queueReorderRequest: QueueReorderRequest(
        (b) => b
          ..version = before.data!.version
          ..items = ListBuilder(<QueueReorderEntry>[
            QueueReorderEntry(
              (e) => e
                ..id = item.id
                ..printerId = 2
                ..position = 0,
            ),
          ]),
      ),
    );

    expect(after.statusCode, 200);
    expect(after.data!.version, before.data!.version + 1);
    expect(after.data!.byPrinter['2']!.map((i) => i.id), contains(item.id));
  });
}
