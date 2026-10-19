/// Backend simulado en memoria para desarrollar la app sin el backend real.
///
/// Devuelve estructuras JSON que respetan el contrato
/// `packages/api-contract/openapi.yaml`. Se elimina cuando el backend FastAPI
/// exista (ver AGENTS.md, handoff).
///
/// Regla de negocio: la lógica de sugerencia, estados y faltantes se simulan
/// aquí (backend), nunca en la UI.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Credenciales de demostración aceptadas por el mock.
const String kMockPassword = 'novalab';
const String kMockOwnerEmail = 'dueno@novalab.mx';
const String kMockOperatorEmail = 'operador@novalab.mx';

/// Fecha de referencia del mock; hace deterministas las alertas de vencimiento.
final DateTime kMockToday = DateTime(2026, 10, 12);

/// Días de anticipación para marcar un pedido como "próximo a vencer".
const int kMockDueSoonDays = 3;

/// Snapshot PNG de ejemplo (160x90) servido por el mock para la cámara (BE-07).
const String kMockCameraPngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAKAAAABaCAIAAACwpMoFAAACbUlEQVR42u3RV27cMABAQf47iZO4bU9325rei9Pr/a8TCtRCpLS6wMMD5gYT9g7mPRZ7h41rtWXlqGWVXD/OrQsnySa6kRtEj7v2h096PN0fNW7WnlXGLc+TW5Pci8I0eRndzs2iV10Hd173eHNwt3FYe1u51/IuObqfe194kHyIjnMPo49dJ48+9bg6Ob0K7oJ3+4LdhezuDHaXs9sNdhe1OyiD3aXt5sHuAncHp5+Du+DdFOwudndwFoPd5e4Wwe7ydptgd5G7dbC71N0q2F3w7uDsS3AXvJuC3cXuboPdhe4Oz2Owu9zdbrC7qN1WsLu03TzYXeDu8PxrcBe8m4Ldxe42we4id+tgd6m7VbC74N3hRRHsLm03D3YXuDu8+BbcBe+mYHexu6N2sLus3TLYXdxuFuwucXcb7C50d3QZg93l7o4uvwd3wbsp2F3sbh3sLnW3CnYXvFsGu4vbzYLdJe5ug92F7o7nP4K74N0U7C52d3ewu5jdHcHuknbbwe7Cdotgd3m7TbC7yN062F3q7nj+M7gL3h0veoPdJez2BbsL2d0Z7C5ntxvsLmp3Uga7S9vNg90F7k4Wv4K74N0U7C52d7KMwe5yd4tgd3m7TbC7yN062F3qbhXsLnh3svwd3AXvpmB3sbvbYHehu9NVDHaXu9sNdhe12wp2l7abB7sL3J2u/gR3wbsp2F3sbhPsLnK3DnaXulsFuwvena6LYHdpu3mwu8Dd6fpvcBe8m4Ldxe7O2sHusnbLYHdxu1mwu8TdbbC70N3ZJga7y92dbf4Fd8G7Kdhd7G4d7C51twp2F7xbBruL243+A+qp/ZNFR7ukAAAAAElFTkSuQmCC';

/// Resultado de una petición simulada.
class MockResponse {
  const MockResponse(
    this.statusCode,
    this.data, {
    this.contentType = 'application/json',
  });

  final int statusCode;
  final Object? data;
  final String contentType;
}

class MockBackend {
  MockBackend() {
    _reset();
  }

  int _queueVersion = 1;
  int _nextJobId = 1;
  int _nextOrderId = 1006;
  int _nextCustomerId = 6;
  int _nextItemId = 7;
  int _nextUserId = 3;
  int _nextOrgId = 2;
  int _nextRequestId = 1;
  int _nextPrinterId = 4;
  int _currentUserId = 1;

  /// Correos ya registrados (los de demo cuentan como tomados).
  final Set<String> _registeredEmails = <String>{
    kMockOwnerEmail,
    kMockOperatorEmail,
  };

  late List<Map<String, Object?>> _printers;
  late List<Map<String, Object?>> _queueItems;
  late List<Map<String, Object?>> _customers;
  late List<Map<String, Object?>> _products;
  late Map<int, Map<String, Object?>> _orders;
  late List<Map<String, Object?>> _jobs;
  late Map<int, Map<String, Object?>> _organizations;
  late Map<int, Map<String, Object?>> _userOrgMap;
  late List<Map<String, Object?>> _operatorRequests;

  /// G-code subido por job (solo el nombre vive en `job['current_file']`).
  late Map<int, Uint8List> _gcodeFiles;

  /// Logo por organización (extensión incluida para el content-type).
  late Map<int, ({Uint8List bytes, String ext})> _orgLogos;

  void _reset() {
    _queueVersion = 1;
    _nextJobId = 1;
    _nextOrderId = 1006;
    _nextCustomerId = 6;
    _nextItemId = 7;
    _nextUserId = 3;
    _nextOrgId = 2;
    _nextRequestId = 1;
    _nextPrinterId = 4;
    _currentUserId = 1;
    _registeredEmails
      ..clear()
      ..addAll(<String>{kMockOwnerEmail, kMockOperatorEmail});
    _organizations = <int, Map<String, Object?>>{
      1: <String, Object?>{
        'id': 1,
        'code': 'ORG-NOVA-101',
        'name': 'NOVALAB Demo',
        'description': null,
        'vision': null,
        'mission': null,
        'has_logo': false,
        'owner_id': 1,
        'created_at': '2026-10-12T08:00:00Z',
      },
    };
    _userOrgMap = <int, Map<String, Object?>>{
      1: <String, Object?>{
        'id': 1,
        'name': 'Dueño Demo',
        'email': kMockOwnerEmail,
        'role': 'owner',
        'organization_id': 1,
        'organization_code': 'ORG-NOVA-101',
        'membership_status': 'active',
      },
      2: <String, Object?>{
        'id': 2,
        'name': 'Operador Demo',
        'email': kMockOperatorEmail,
        'role': 'operator',
        'organization_id': 1,
        'organization_code': 'ORG-NOVA-101',
        'membership_status': 'active',
      },
    };
    _operatorRequests = <Map<String, Object?>>[];
    _gcodeFiles = <int, Uint8List>{};
    _orgLogos = <int, ({Uint8List bytes, String ext})>{};
    _jobs = <Map<String, Object?>>[];
    _products = <Map<String, Object?>>[
      _product(1, 'Vaso', 'PETG', 'Negro', 45, 180, 20, 250),
      _product(2, 'Base para celular', 'PLA', 'Blanco', 20, 95, 10, 150),
      _product(3, 'Engrane', 'PLA', 'Blanco', 8, 40, 5, 60),
      _product(4, 'Llavero', 'PLA', 'Rojo', 5, 15, 2, 40),
      _product(5, 'Maceta', 'PLA', 'Verde', 60, 210, 30, 300),
    ];
    _customers = <Map<String, Object?>>[
      _customer(1, 'María', '555-0101', 'maria@example.com'),
      _customer(2, 'Juan', '555-0102', 'juan@example.com'),
      _customer(3, 'Carlos', '555-0103', 'carlos@example.com'),
      _customer(4, 'Ana', '555-0104', 'ana@example.com'),
      _customer(5, 'Luis', '555-0105', 'luis@example.com'),
    ];
    _printers = <Map<String, Object?>>[
      <String, Object?>{
        'id': 1,
        'name': 'Impresora 1',
        'model': 'Prusa MK4',
        'state': 'printing',
        'progress': 42.5,
        'remaining_seconds': 1800,
        'nozzle_temp': 209.4,
        'nozzle_target': 210.0,
        'bed_temp': 59.8,
        'bed_target': 60.0,
        'current_file': 'vaso_petg.gcode',
        'camera_available': true,
        'cameras': <String>['mock://cam1/0', 'mock://cam1/1'],
        'loaded_spool': <String, Object?>{
          'id': 11,
          'material': 'PETG',
          'color': 'Negro',
          'grams_remaining': 780.0,
        },
        'current_order': <String, Object?>{
          'id': 1001,
          'folio': 'NL-1001',
          'customer_name': 'María',
          'promised_date': '2026-10-16',
        },
        'last_seen': '2026-10-12T18:05:00Z',
      },
      <String, Object?>{
        'id': 2,
        'name': 'Impresora 2',
        'model': 'Creality Ender 3 V3',
        'state': 'idle',
        'camera_available': true,
        'cameras': <String>['mock://cam2/0'],
        'loaded_spool': <String, Object?>{
          'id': 12,
          'material': 'PLA',
          'color': 'Blanco',
          'grams_remaining': 1200.0,
        },
        'last_seen': '2026-10-12T18:05:00Z',
      },
      <String, Object?>{
        'id': 3,
        'name': 'Impresora 3',
        'model': 'Bambu Lab A1',
        'state': 'offline',
        'camera_available': false,
        'last_seen': null,
      },
    ];
    _queueItems = <Map<String, Object?>>[
      _item(
        id: 1,
        orderId: 1001,
        productId: 1,
        product: 'Vaso',
        color: 'Negro',
        qty: 5,
        printed: 2,
        state: 'printing',
        printerId: 1,
        position: 0,
        minutes: 180,
        promised: '2026-10-16',
      ),
      _item(
        id: 2,
        orderId: 1002,
        productId: 2,
        product: 'Base para celular',
        color: 'Blanco',
        qty: 1,
        printed: 0,
        state: 'queued',
        printerId: 2,
        position: 0,
        minutes: 95,
        promised: '2026-10-13',
      ),
      _item(
        id: 3,
        orderId: 1003,
        productId: 3,
        product: 'Engrane',
        color: 'Blanco',
        qty: 8,
        printed: 0,
        state: 'queued',
        printerId: 2,
        position: 1,
        minutes: 40,
        promised: '2026-10-10',
      ),
      _item(
        id: 5,
        orderId: 1004,
        productId: 4,
        product: 'Llavero',
        color: 'Rojo',
        qty: 10,
        printed: 0,
        state: 'pending',
        printerId: null,
        position: 0,
        minutes: 15,
        promised: '2026-10-18',
      ),
      _item(
        id: 6,
        orderId: 1005,
        productId: 5,
        product: 'Maceta',
        color: 'Verde',
        qty: 2,
        printed: 0,
        state: 'pending',
        printerId: null,
        position: 1,
        minutes: 210,
        promised: '2026-10-25',
      ),
    ];
    _orders = <int, Map<String, Object?>>{
      1001: _order(
        folio: 'NL-1001',
        customerId: 1,
        promised: '2026-10-16',
        total: 1250,
        notes: 'Cliente frecuente.',
        history: <Map<String, Object?>>[
          _h('confirmed', null, '2026-10-10T09:00:00Z', 'Dueño Demo'),
          _h('queued', 'confirmed', '2026-10-10T09:05:00Z', 'Dueño Demo'),
          _h('printing', 'queued', '2026-10-12T17:00:00Z', 'Operador Demo'),
        ],
      ),
      1002: _order(
        folio: 'NL-1002',
        customerId: 2,
        promised: '2026-10-13',
        total: 150,
        history: <Map<String, Object?>>[
          _h('confirmed', null, '2026-10-11T11:00:00Z', 'Dueño Demo'),
          _h('queued', 'confirmed', '2026-10-11T11:10:00Z', 'Operador Demo'),
        ],
      ),
      1003: _order(
        folio: 'NL-1003',
        customerId: 3,
        promised: '2026-10-10',
        total: 480,
        notes: 'Atrasado: revisar con el cliente.',
        history: <Map<String, Object?>>[
          _h('confirmed', null, '2026-10-08T15:00:00Z', 'Dueño Demo'),
          _h('queued', 'confirmed', '2026-10-08T15:20:00Z', 'Operador Demo'),
        ],
      ),
      1004: _order(
        folio: 'NL-1004',
        customerId: 4,
        promised: '2026-10-18',
        total: 400,
        history: <Map<String, Object?>>[
          _h('confirmed', null, '2026-10-12T08:00:00Z', 'Dueño Demo'),
        ],
      ),
      1005: _order(
        folio: 'NL-1005',
        customerId: 5,
        promised: '2026-10-25',
        total: 600,
        history: <Map<String, Object?>>[
          _h('confirmed', null, '2026-10-12T09:30:00Z', 'Dueño Demo'),
        ],
      ),
    };
  }

  static Map<String, Object?> _customer(
    int id,
    String name,
    String phone,
    String email,
  ) => <String, Object?>{
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'notes': null,
  };

  static Map<String, Object?> _product(
    int id,
    String name,
    String material,
    String color,
    double weightG,
    int minutes,
    double extraCost,
    double basePrice,
  ) => <String, Object?>{
    'id': id,
    'name': name,
    'material': material,
    'color': color,
    'estimated_weight_g': weightG,
    'estimated_minutes': minutes,
    'extra_cost': extraCost,
    'has_gcode': true,
    'base_price': basePrice,
  };

  static Map<String, Object?> _order({
    required String folio,
    required int customerId,
    required String? promised,
    required double total,
    String? notes,
    required List<Map<String, Object?>> history,
  }) => <String, Object?>{
    'folio': folio,
    'customer_id': customerId,
    'manual_status': null,
    'promised_date': promised,
    'total': total,
    'tracking_token': 'demo-token-${folio.split('-').last}',
    'notes': notes,
    'created_at': '2026-10-10T09:00:00Z',
    'history': history,
    'shipment': null,
  };

  static Map<String, Object?> _h(
    String status,
    String? previous,
    String when,
    String user,
  ) => <String, Object?>{
    'status': status,
    'previous_status': previous,
    'user_name': user,
    'occurred_at': when,
  };

  static Map<String, Object?> _item({
    required int id,
    required int orderId,
    required int productId,
    required String product,
    required String color,
    required int qty,
    required int printed,
    required String state,
    required int? printerId,
    required int position,
    required int minutes,
    required String? promised,
  }) {
    return <String, Object?>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'order_folio': 'NL-$orderId',
      'product_name': product,
      'color': color,
      'quantity': qty,
      'printed_quantity': printed,
      'missing_quantity': qty - printed,
      'state': state,
      'printer_id': printerId,
      'position': position,
      'estimated_minutes': minutes,
      'promised_date': promised,
    };
  }

  /// Despacha una petición contra el estado simulado.
  ///
  /// Devuelve `null` si la ruta no está simulada, para que la petición siga su
  /// curso hacia el backend real. Es `async` porque las rutas multipart
  /// (G-code, logo) leen el archivo del [FormData].
  Future<MockResponse?> handle(
    String method,
    String path,
    Object? body, {
    Map<String, dynamic>? query,
  }) async {
    final cameraMatch = RegExp(
      r'^/api/printers/(\d+)/camera/snapshot$',
    ).firstMatch(path);
    if (method == 'GET' && cameraMatch != null) {
      final index = int.tryParse('${query?['index'] ?? '0'}') ?? 0;
      return _cameraSnapshot(int.parse(cameraMatch.group(1)!), index);
    }

    final testByIdMatch = RegExp(
      r'^/api/printers/(\d+)/test$',
    ).firstMatch(path);
    if (method == 'POST' && testByIdMatch != null) {
      return _testConnectionById(int.parse(testByIdMatch.group(1)!));
    }

    final gcodeMatch = RegExp(
      r'^/api/print-jobs/(\d+)/gcode$',
    ).firstMatch(path);
    if (gcodeMatch != null) {
      final jobId = int.parse(gcodeMatch.group(1)!);
      if (method == 'POST') return _uploadGcode(jobId, body);
      if (method == 'GET') return _downloadGcode(jobId);
    }

    final jobMatch = RegExp(
      r'^/api/print-jobs/(\d+)/(complete|fail|reprint)$',
    ).firstMatch(path);
    if (method == 'POST' && jobMatch != null) {
      final jobId = int.parse(jobMatch.group(1)!);
      return switch (jobMatch.group(2)) {
        'complete' => _completeJob(jobId),
        'fail' => _failJob(jobId, body),
        _ => _reprintJob(jobId),
      };
    }

    final orderMatch = RegExp(r'^/api/orders/(\d+)$').firstMatch(path);
    if (method == 'GET' && orderMatch != null) {
      return _getOrder(int.parse(orderMatch.group(1)!));
    }
    final orderStatusMatch = RegExp(
      r'^/api/orders/(\d+)/status$',
    ).firstMatch(path);
    if (method == 'PATCH' && orderStatusMatch != null) {
      return _updateOrderStatus(int.parse(orderStatusMatch.group(1)!), body);
    }

    final printerMatch = RegExp(r'^/api/printers/(\d+)$').firstMatch(path);
    if (printerMatch != null) {
      final pid = int.parse(printerMatch.group(1)!);
      if (method == 'GET') return _getPrinter(pid);
      if (method == 'PATCH') return _updatePrinter(pid, body);
      if (method == 'DELETE') return _deletePrinter(pid);
    }

    final customerMatch = RegExp(r'^/api/customers/(\d+)$').firstMatch(path);
    if (customerMatch != null && method == 'GET') {
      return _getCustomer(int.parse(customerMatch.group(1)!));
    }

    final orgRequestMatch = RegExp(
      r'^/api/organizations/requests/(\d+)/(approve|reject)$',
    ).firstMatch(path);
    if (method == 'POST' && orgRequestMatch != null) {
      final reqId = int.parse(orgRequestMatch.group(1)!);
      return orgRequestMatch.group(2) == 'approve'
          ? _approveRequest(reqId)
          : _rejectRequest(reqId);
    }

    switch ('$method $path') {
      case 'POST /api/auth/login':
        return _login(body);
      case 'POST /api/auth/register':
        return _register(body);
      case 'POST /api/auth/refresh':
        return _refresh(body);
      case 'POST /api/organizations':
        return _createOrganization(body);
      case 'PATCH /api/organizations':
        return _updateOrganization(body);
      case 'GET /api/organizations/current':
        return _getCurrentOrganization();
      case 'GET /api/organizations/members':
        return _listMembers();
      case 'POST /api/organizations/logo':
        return _uploadLogo(body);
      case 'GET /api/organizations/logo':
        return _downloadLogo();
      case 'DELETE /api/organizations/logo':
        return _deleteLogo();
      case 'POST /api/organizations/join':
        return _joinOrganization(body);
      case 'GET /api/organizations/requests':
        return _listRequests();
      case 'GET /api/public/branding':
        return const MockResponse(200, _branding);
      case 'GET /api/printers':
        return MockResponse(200, _printers);
      case 'POST /api/printers':
        return _createPrinter(body);
      case 'POST /api/printers/test':
        return _testConnection(body);
      case 'GET /api/queue':
        return MockResponse(200, _buildQueue());
      case 'PATCH /api/queue/reorder':
        return _reorder(body);
      case 'POST /api/queue/suggest':
        return _suggest();
      case 'POST /api/queue/accept':
        return _accept(body);
      case 'POST /api/print-jobs':
        return _startJob(body);
      case 'GET /api/customers':
        return MockResponse(200, _customers);
      case 'POST /api/customers':
        return _createCustomer(body);
      case 'GET /api/products':
        return MockResponse(200, _products);
      case 'GET /api/orders':
        return _listOrders(query ?? const <String, dynamic>{});
      case 'POST /api/orders':
        return _createOrder(body);
    }
    return null;
  }

  MockResponse _login(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final email = (map['email'] as String?) ?? '';
    final password = (map['password'] as String?) ?? '';
    if (password != kMockPassword) {
      return const MockResponse(401, <String, Object?>{
        'code': 'invalid_credentials',
        'message': 'Credenciales incorrectas.',
      });
    }
    final isOperator = email.startsWith('operador');
    _currentUserId = isOperator ? 2 : 1;
    final existing = _userOrgMap.values
        .cast<Map<String, Object?>?>()
        .firstWhere((u) => u?['email'] == email, orElse: () => null);
    if (existing != null) {
      _currentUserId = existing['id'] as int;
      return MockResponse(200, <String, Object?>{
        'access_token': 'mock-access-${DateTime.now().millisecondsSinceEpoch}',
        'refresh_token': 'mock-refresh-token',
        'token_type': 'bearer',
        'user': existing,
      });
    }
    return MockResponse(200, _loginResponse(isOperator));
  }

  MockResponse _register(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final name = ((map['name'] as String?) ?? '').trim();
    final email = ((map['email'] as String?) ?? '').trim().toLowerCase();
    final password = (map['password'] as String?) ?? '';
    final role = (map['role'] as String?) ?? 'operator';
    if (name.isEmpty || !email.contains('@') || password.length < 8) {
      return const MockResponse(422, <String, Object?>{
        'code': 'invalid',
        'message': 'Datos inválidos.',
      });
    }
    if (_registeredEmails.contains(email)) {
      return const MockResponse(409, <String, Object?>{
        'code': 'email_taken',
        'message': 'Ese correo ya está registrado.',
      });
    }
    _registeredEmails.add(email);
    final id = _nextUserId++;
    _currentUserId = id;
    final userData = <String, Object?>{
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'organization_id': null,
      'organization_code': null,
      'membership_status': 'none',
    };
    _userOrgMap[id] = userData;
    return MockResponse(201, <String, Object?>{
      'access_token': 'mock-access-${DateTime.now().millisecondsSinceEpoch}',
      'refresh_token': 'mock-refresh-token',
      'token_type': 'bearer',
      'user': userData,
    });
  }

  MockResponse _refresh(Object? body) =>
      MockResponse(200, _loginResponse(false));

  Map<String, Object?> _loginResponse(bool operator) {
    final id = operator ? 2 : 1;
    final user =
        _userOrgMap[id] ??
        <String, Object?>{
          'id': id,
          'name': operator ? 'Operador Demo' : 'Dueño Demo',
          'email': operator ? kMockOperatorEmail : kMockOwnerEmail,
          'role': operator ? 'operator' : 'owner',
          'organization_id': 1,
          'organization_code': 'ORG-NOVA-101',
          'membership_status': 'active',
        };
    return <String, Object?>{
      'access_token': 'mock-access-${DateTime.now().millisecondsSinceEpoch}',
      'refresh_token': 'mock-refresh-token',
      'token_type': 'bearer',
      'user': user,
    };
  }

  MockResponse _createOrganization(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final name = ((map['name'] as String?) ?? '').trim();
    if (name.length < 2) {
      return const MockResponse(400, <String, Object?>{
        'code': 'invalid_name',
        'message': 'El nombre debe tener al menos 2 caracteres.',
      });
    }
    for (final org in _organizations.values) {
      if ((org['name'] as String).toLowerCase() == name.toLowerCase()) {
        return const MockResponse(400, <String, Object?>{
          'code': 'name_taken',
          'message': 'Ese nombre de organización ya está en uso.',
        });
      }
    }
    final orgId = _nextOrgId++;
    final cleanName = name.replaceAll(RegExp(r'\s+'), '').toUpperCase();
    final prefix = cleanName.length >= 4
        ? cleanName.substring(0, 4)
        : cleanName.padRight(4, 'X');
    final code = 'ORG-$prefix-$orgId';
    final org = <String, Object?>{
      'id': orgId,
      'code': code,
      'name': name,
      'description': _identityText(map['description']),
      'vision': _identityText(map['vision']),
      'mission': _identityText(map['mission']),
      'has_logo': false,
      'owner_id': _currentUserId,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    };
    _organizations[orgId] = org;
    final user = _userOrgMap[_currentUserId];
    if (user != null) {
      user['organization_id'] = orgId;
      user['organization_code'] = code;
      user['membership_status'] = 'active';
    }
    return MockResponse(201, org);
  }

  MockResponse _getCurrentOrganization() {
    final user = _userOrgMap[_currentUserId];
    final orgId = user?['organization_id'] as int?;
    final org = orgId != null ? _organizations[orgId] : null;
    final status = (user?['membership_status'] as String?) ?? 'none';
    final pendingCount = _operatorRequests
        .where((r) => r['status'] == 'pending')
        .length;
    return MockResponse(200, <String, Object?>{
      'organization': org,
      'membership_status': status,
      'pending_requests_count': pendingCount,
    });
  }

  MockResponse _joinOrganization(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final code = ((map['organization_code'] as String?) ?? '')
        .trim()
        .toUpperCase();
    Map<String, Object?>? targetOrg;
    for (final org in _organizations.values) {
      if ((org['code'] as String).toUpperCase() == code) {
        targetOrg = org;
        break;
      }
    }
    if (targetOrg == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Organización no encontrada con ese ID.',
      });
    }
    final user = _userOrgMap[_currentUserId];
    final orgId = targetOrg['id'] as int;
    if (user != null) {
      user['organization_id'] = orgId;
      user['organization_code'] = targetOrg['code'];
      user['membership_status'] = 'pending';
    }
    final reqId = _nextRequestId++;
    final req = <String, Object?>{
      'id': reqId,
      'user_id': _currentUserId,
      'user_name': user?['name'] ?? 'Operador',
      'user_email': user?['email'] ?? 'operador@ejemplo.mx',
      'role': 'operator',
      'status': 'pending',
      'organization_code': targetOrg['code'],
      'organization_name': targetOrg['name'],
      'created_at': DateTime.now().toUtc().toIso8601String(),
    };
    _operatorRequests.add(req);
    return MockResponse(200, <String, Object?>{
      'organization': targetOrg,
      'membership_status': 'pending',
      'pending_requests_count': 0,
    });
  }

  MockResponse _listRequests() {
    final pending = _operatorRequests
        .where((r) => r['status'] == 'pending')
        .toList();
    return MockResponse(200, pending);
  }

  MockResponse _approveRequest(int reqId) {
    final req = _operatorRequests.cast<Map<String, Object?>?>().firstWhere(
      (r) => r?['id'] == reqId,
      orElse: () => null,
    );
    if (req == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Solicitud no encontrada.',
      });
    }
    req['status'] = 'active';
    final userId = req['user_id'] as int;
    final user = _userOrgMap[userId];
    if (user != null) {
      user['membership_status'] = 'active';
    }
    return MockResponse(200, req);
  }

  MockResponse _rejectRequest(int reqId) {
    final req = _operatorRequests.cast<Map<String, Object?>?>().firstWhere(
      (r) => r?['id'] == reqId,
      orElse: () => null,
    );
    if (req == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Solicitud no encontrada.',
      });
    }
    req['status'] = 'rejected';
    final userId = req['user_id'] as int;
    final user = _userOrgMap[userId];
    if (user != null) {
      user['membership_status'] = 'rejected';
    }
    return MockResponse(200, req);
  }

  static const Map<String, Object?> _branding = <String, Object?>{
    'business_name': 'NOVALAB',
    'logo_url': null,
    'primary_color': '#0B132B',
    'accent_color': '#00FF87',
    'background_color': '#FFFFFF',
    'currency': 'MXN',
    'timezone': 'America/Mexico_City',
    'language': 'es-MX',
  };

  /// Normaliza un campo de identidad: `''` → `null` (mismo criterio que el
  /// backend, para poder limpiar valores desde el cliente).
  static String? _identityText(Object? value) {
    if (value is! String) return null;
    final text = value.trim();
    return text.isEmpty ? null : text;
  }

  MockResponse _updateOrganization(Object? body) {
    final owner = _currentOrgForOwner();
    if (owner is MockResponse) return owner;
    final org = owner as Map<String, Object?>;
    final map = body is Map ? body : const <String, Object?>{};
    if (map.containsKey('name') && map['name'] != null) {
      final newName = ((map['name'] as String?) ?? '').trim();
      if (newName.length < 2) {
        return const MockResponse(400, <String, Object?>{
          'code': 'invalid_name',
          'message': 'El nombre debe tener al menos 2 caracteres.',
        });
      }
      for (final other in _organizations.values) {
        if (other['id'] != org['id'] &&
            (other['name'] as String).toLowerCase() == newName.toLowerCase()) {
          return const MockResponse(400, <String, Object?>{
            'code': 'name_taken',
            'message': 'Ese nombre de organización ya está en uso.',
          });
        }
      }
      org['name'] = newName;
    }
    for (final field in <String>['description', 'vision', 'mission']) {
      if (map.containsKey(field)) {
        org[field] = _identityText(map[field]);
      }
    }
    return MockResponse(200, org);
  }

  /// Dueño actual con organización; `MockResponse` (error) si no califica.
  Object _currentOrgForOwner() {
    final user = _userOrgMap[_currentUserId];
    if (user == null || user['role'] != 'owner') {
      return const MockResponse(403, <String, Object?>{
        'code': 'forbidden',
        'message': 'Requiere rol owner.',
      });
    }
    final orgId = user['organization_id'] as int?;
    final org = orgId != null ? _organizations[orgId] : null;
    if (org == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'No perteneces a ninguna organización.',
      });
    }
    return org;
  }

  MockResponse _listMembers() {
    final owner = _currentOrgForOwner();
    if (owner is MockResponse) return owner;
    final org = owner as Map<String, Object?>;
    final members = <Map<String, Object?>>[];
    for (final user in _userOrgMap.values) {
      if (user['organization_id'] != org['id']) continue;
      final status = (user['membership_status'] as String?) ?? 'none';
      if (status != 'active') continue;
      members.add(<String, Object?>{
        'id': user['id'],
        'user_id': user['id'],
        'user_name': user['name'],
        'user_email': user['email'],
        'role': user['role'],
        'status': status,
        'organization_code': org['code'],
        'organization_name': org['name'],
        'created_at': org['created_at'],
      });
    }
    return MockResponse(200, members);
  }

  Future<MockResponse> _uploadLogo(Object? body) async {
    final owner = _currentOrgForOwner();
    if (owner is MockResponse) return owner;
    final org = owner as Map<String, Object?>;
    final file = await _formFile(body);
    if (file == null) {
      return const MockResponse(422, <String, Object?>{
        'code': 'missing_file',
        'message': 'Falta el archivo.',
      });
    }
    final ext = _extensionOf(file.$1);
    if (!const <String>{'.png', '.jpg', '.jpeg', '.webp'}.contains(ext)) {
      return const MockResponse(415, <String, Object?>{
        'code': 'unsupported_media_type',
        'message': 'Extensión no soportada; usa png, jpeg o webp.',
      });
    }
    if (file.$2.length > 5 * 1024 * 1024) {
      return const MockResponse(413, <String, Object?>{
        'code': 'file_too_large',
        'message': 'El archivo supera el máximo de 5 MB.',
      });
    }
    if (file.$2.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'empty_file',
        'message': 'El archivo está vacío.',
      });
    }
    _orgLogos[org['id']! as int] = (bytes: file.$2, ext: ext);
    org['has_logo'] = true;
    return MockResponse(200, org);
  }

  MockResponse _downloadLogo() {
    final user = _userOrgMap[_currentUserId];
    final orgId = user?['organization_id'] as int?;
    final org = orgId != null ? _organizations[orgId] : null;
    final logo = orgId != null ? _orgLogos[orgId] : null;
    if (org == null || logo == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'La organización no tiene logo.',
      });
    }
    final media = switch (logo.ext) {
      '.jpg' || '.jpeg' => 'image/jpeg',
      '.webp' => 'image/webp',
      _ => 'image/png',
    };
    return MockResponse(200, logo.bytes, contentType: media);
  }

  MockResponse _deleteLogo() {
    final owner = _currentOrgForOwner();
    if (owner is MockResponse) return owner;
    final org = owner as Map<String, Object?>;
    _orgLogos.remove(org['id']! as int);
    org['has_logo'] = false;
    return MockResponse(200, org);
  }

  Future<MockResponse> _uploadGcode(int jobId, Object? body) async {
    final job = _jobById(jobId);
    if (job == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Job no encontrado.',
      });
    }
    final file = await _formFile(body);
    if (file == null) {
      return const MockResponse(422, <String, Object?>{
        'code': 'missing_file',
        'message': 'Falta el archivo.',
      });
    }
    final ext = _extensionOf(file.$1);
    if (!const <String>{'.gcode', '.gco', '.g'}.contains(ext)) {
      return MockResponse(415, <String, Object?>{
        'code': 'unsupported_media_type',
        'message': 'Extensión no soportada: $ext.',
      });
    }
    if (file.$2.length > 50 * 1024 * 1024) {
      return const MockResponse(413, <String, Object?>{
        'code': 'file_too_large',
        'message': 'El archivo supera el máximo de 50 MB.',
      });
    }
    if (file.$2.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'empty_file',
        'message': 'El archivo está vacío.',
      });
    }
    _gcodeFiles[jobId] = file.$2;
    job['current_file'] = file.$1;
    final printer = _printerById(job['printer_id'] as int?);
    if (printer != null) printer['current_file'] = file.$1;
    return MockResponse(200, job);
  }

  MockResponse _downloadGcode(int jobId) {
    final job = _jobById(jobId);
    final bytes = _gcodeFiles[jobId];
    if (job == null || bytes == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Job sin archivo G-code.',
      });
    }
    return MockResponse(200, bytes, contentType: 'application/octet-stream');
  }

  /// Extrae el primer archivo de un [FormData] multipart.
  Future<(String, Uint8List)?> _formFile(Object? body) async {
    if (body is! FormData || body.files.isEmpty) return null;
    final file = body.files.first.value;
    final builder = BytesBuilder(copy: false);
    await for (final chunk in file.finalize()) {
      builder.add(chunk);
    }
    return (file.filename ?? 'archivo', builder.takeBytes());
  }

  static String _extensionOf(String filename) {
    final index = filename.lastIndexOf('.');
    return index == -1 ? '' : filename.substring(index).toLowerCase();
  }

  Map<String, Object?> _buildQueue() {
    final unassigned = <Map<String, Object?>>[];
    final byPrinter = <String, List<Map<String, Object?>>>{};
    for (final item in _queueItems) {
      final printerId = item['printer_id'];
      if (printerId == null) {
        unassigned.add(item);
      } else {
        byPrinter.putIfAbsent('$printerId', () => []).add(item);
      }
    }
    int byPosition(Map<String, Object?> a, Map<String, Object?> b) =>
        (a['position']! as int).compareTo(b['position']! as int);
    unassigned.sort(byPosition);
    for (final list in byPrinter.values) {
      list.sort(byPosition);
    }
    return <String, Object?>{
      'unassigned': unassigned,
      'by_printer': byPrinter,
      'version': _queueVersion,
    };
  }

  MockResponse _reorder(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final clientVersion = map['version'];
    if (clientVersion is int && clientVersion != _queueVersion) {
      return const MockResponse(409, <String, Object?>{
        'code': 'queue_version_conflict',
        'message': 'La cola cambió en otro dispositivo. Vuelve a cargar.',
      });
    }
    final entries = map['items'];
    if (entries is List) {
      for (final raw in entries) {
        if (raw is! Map) continue;
        final id = raw['id'];
        final match = _queueItems.where((i) => i['id'] == id).toList();
        if (match.isEmpty) continue;
        match.first['printer_id'] = raw['printer_id'];
        match.first['position'] = raw['position'] ?? 0;
      }
    }
    _queueVersion++;
    return MockResponse(200, _buildQueue());
  }

  MockResponse _cameraSnapshot(int printerId, int index) {
    final match = _printers.where((p) => p['id'] == printerId).toList();
    if (match.isEmpty || match.first['camera_available'] != true) {
      return const MockResponse(404, <String, Object?>{
        'code': 'camera_unavailable',
        'message': 'La impresora no tiene cámara o aún no hay snapshot.',
      });
    }
    final cameras = match.first['cameras'] as List<Object?>? ?? const [];
    if (index >= cameras.length) {
      return const MockResponse(404, <String, Object?>{
        'code': 'camera_unavailable',
        'message': 'Índice de cámara fuera de rango.',
      });
    }
    return MockResponse(
      200,
      base64Decode(kMockCameraPngBase64),
      contentType: 'image/png',
    );
  }

  // BE-01: probar conexión a OctoPrint (mock siempre responde ok si hay URL).
  MockResponse _testConnection(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final url =
        ((map['octoprint_url'] ?? map['octoprintUrl']) as String?)?.trim() ??
        '';
    if (url.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'invalid_url',
        'message': 'La URL de OctoPrint es obligatoria.',
      });
    }
    return MockResponse(200, <String, Object?>{
      'ok': true,
      'message': 'Conexión exitosa con OctoPrint.',
      'version': '1.10.3 (mock)',
    });
  }

  MockResponse _testConnectionById(int printerId) {
    final printer = _printerById(printerId);
    if (printer == null || printer['octoprint_url'] == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Impresora sin URL de OctoPrint configurada.',
      });
    }
    return MockResponse(200, <String, Object?>{
      'ok': true,
      'message': 'Conexión exitosa con OctoPrint.',
      'version': '1.10.3 (mock)',
    });
  }

  // --- CRUD Impresoras ----------------------------------------------------

  MockResponse _createPrinter(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final name = (map['name'] as String?)?.trim() ?? '';
    if (name.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'invalid_name',
        'message': 'El nombre de la impresora es obligatorio.',
      });
    }
    final id = _nextPrinterId++;
    final model = ((map['model'] as String?) ?? '').trim();
    final printer = <String, Object?>{
      'id': id,
      'name': name,
      'model': model.isEmpty ? null : model,
      'state': 'idle',
      'progress': null,
      'remaining_seconds': null,
      'nozzle_temp': null,
      'nozzle_target': null,
      'bed_temp': null,
      'bed_target': null,
      'current_file': null,
      'octoprint_url': map['octoprint_url'] as String?,
      'api_key': null,
      'camera_available': (map['camera_available'] as bool?) ?? false,
      'cameras': (map['cameras'] as List<Object?>?) ?? const <String>[],
      'loaded_spool': null,
      'current_order': null,
      'last_seen': _now(),
    };
    _printers.add(printer);
    return MockResponse(201, printer);
  }

  MockResponse _getPrinter(int printerId) {
    final printer = _printerById(printerId);
    if (printer == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Impresora no encontrada.',
      });
    }
    return MockResponse(200, printer);
  }

  MockResponse _updatePrinter(int printerId, Object? body) {
    final printer = _printerById(printerId);
    if (printer == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Impresora no encontrada.',
      });
    }
    final map = body is Map ? body : const <String, Object?>{};
    if (map.containsKey('name')) {
      final name = (map['name'] as String?)?.trim() ?? '';
      if (name.isNotEmpty) printer['name'] = name;
    }
    if (map.containsKey('model')) {
      final model = (map['model'] as String?)?.trim() ?? '';
      printer['model'] = model.isEmpty ? null : model;
    }
    if (map.containsKey('camera_available')) {
      printer['camera_available'] = map['camera_available'] as bool? ?? false;
    }
    if (map.containsKey('cameras')) {
      printer['cameras'] = (map['cameras'] as List<Object?>?) ?? const [];
    }
    if (map.containsKey('octoprint_url')) {
      printer['octoprint_url'] = map['octoprint_url'] as String?;
    }
    if (map.containsKey('state')) {
      printer['state'] = (map['state'] as String?) ?? printer['state'];
    }
    return MockResponse(200, printer);
  }

  MockResponse _deletePrinter(int printerId) {
    final printer = _printerById(printerId);
    if (printer == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Impresora no encontrada.',
      });
    }
    _printers.removeWhere((p) => p['id'] == printerId);
    for (final item in _queueItems) {
      if (item['printer_id'] == printerId) {
        item['printer_id'] = null;
        if (item['state'] == 'printing') {
          item['state'] = 'queued';
        }
      }
    }
    _queueVersion++;
    return const MockResponse(204, null);
  }

  // --- Clientes -----------------------------------------------------------

  MockResponse _createCustomer(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final name = (map['name'] as String?)?.trim() ?? '';
    if (name.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'invalid_name',
        'message': 'El nombre del cliente es obligatorio.',
      });
    }
    final id = _nextCustomerId++;
    final cust = _customer(
      id,
      name,
      (map['phone'] as String?) ?? '',
      (map['email'] as String?) ?? '',
    );
    if (map.containsKey('notes')) {
      cust['notes'] = map['notes'];
    }
    _customers.add(cust);
    return MockResponse(201, cust);
  }

  MockResponse _getCustomer(int customerId) {
    final cust = _firstWhereOrNull(_customers, (c) => c['id'] == customerId);
    if (cust == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Cliente no encontrado.',
      });
    }
    return MockResponse(200, cust);
  }

  // --- P-04: sugerencia de asignación -------------------------------------

  MockResponse _suggest() {
    final pending = _queueItems.where((i) => i['printer_id'] == null).toList()
      ..sort(_byPromisedDate);
    final printers = _printers.where((p) => p['state'] != 'offline').toList();

    final load = <int, int>{for (final p in printers) p['id']! as int: 0};
    for (final item in _queueItems) {
      final pid = item['printer_id'];
      if (pid is int && load.containsKey(pid)) {
        load[pid] = load[pid]! + ((item['estimated_minutes'] as int?) ?? 0);
      }
    }

    final assignments = <Map<String, Object?>>[];
    final unassigned = <int>[];
    for (final item in pending) {
      if (printers.isEmpty) {
        unassigned.add(item['id']! as int);
        continue;
      }
      final product = _productById(item['product_id'] as int?);
      final itemColor = item['color'];
      final itemMaterial = product?['material'];

      Map<String, Object?>? best;
      var bestScore = 1 << 30;
      for (final printer in printers) {
        final pid = printer['id']! as int;
        final spool = printer['loaded_spool'] as Map<String, Object?>?;
        final sameColor = spool != null && spool['color'] == itemColor;
        final sameMaterial = spool != null && spool['material'] == itemMaterial;
        final score =
            load[pid]! - (sameColor ? 60 : 0) - (sameMaterial ? 30 : 0);
        if (score < bestScore) {
          bestScore = score;
          best = printer;
        }
      }
      if (best == null) {
        unassigned.add(item['id']! as int);
        continue;
      }
      final pid = best['id']! as int;
      load[pid] = load[pid]! + ((item['estimated_minutes'] as int?) ?? 0);
      assignments.add(<String, Object?>{
        'item_id': item['id'],
        'printer_id': pid,
        'printer_name': best['name'],
        'order_folio': item['order_folio'],
        'product_name': item['product_name'],
        'estimated_minutes': item['estimated_minutes'],
        'explanation': _explanation(best, item, product),
      });
    }

    return MockResponse(200, <String, Object?>{
      'version': _queueVersion,
      'summary': assignments.isEmpty
          ? 'No hay items pendientes por asignar.'
          : '${assignments.length} '
                '${assignments.length == 1 ? 'item asignado' : 'items asignados'}.',
      'assignments': assignments,
      'unassigned_item_ids': unassigned,
    });
  }

  String _explanation(
    Map<String, Object?> printer,
    Map<String, Object?> item,
    Map<String, Object?>? product,
  ) {
    final spool = printer['loaded_spool'] as Map<String, Object?>?;
    final folio = item['order_folio'];
    final date = item['promised_date'];
    final due = date == null ? '' : ' y el pedido $folio vence el $date';
    if (spool != null &&
        spool['color'] == item['color'] &&
        spool['material'] == product?['material']) {
      return 'Va en ${printer['name']} porque ya tiene '
          '${spool['material']} ${spool['color']}$due.';
    }
    return 'Va en ${printer['name']} para balancear la carga; '
        'el pedido $folio vence el ${date ?? 'sin fecha'}.';
  }

  MockResponse _accept(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final clientVersion = map['version'];
    if (clientVersion is int && clientVersion != _queueVersion) {
      return const MockResponse(409, <String, Object?>{
        'code': 'queue_version_conflict',
        'message': 'La cola cambió en otro dispositivo. Vuelve a cargar.',
      });
    }
    final entries = map['assignments'];
    if (entries is List) {
      for (final raw in entries) {
        if (raw is! Map) continue;
        final id = raw['item_id'];
        final match = _queueItems.where((i) => i['id'] == id).toList();
        if (match.isEmpty) continue;
        final printerId = raw['printer_id'] as int?;
        match.first['printer_id'] = printerId;
        match.first['position'] = _nextPosition(printerId);
        if (match.first['state'] == 'pending') {
          match.first['state'] = 'queued';
        }
      }
    }
    _queueVersion++;
    return MockResponse(200, _buildQueue());
  }

  int _nextPosition(int? printerId) {
    var max = -1;
    for (final item in _queueItems) {
      if (item['printer_id'] == printerId) {
        final pos = item['position'] as int? ?? 0;
        if (pos > max) max = pos;
      }
    }
    return max + 1;
  }

  // --- P-05 / P-06: print jobs --------------------------------------------

  MockResponse _startJob(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final itemId = map['item_id'] as int?;
    final printerId = map['printer_id'] as int?;
    final item = _itemById(itemId);
    final printer = _printerById(printerId);
    if (item == null || printer == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Item o impresora no encontrados.',
      });
    }
    if (printer['state'] == 'offline') {
      return const MockResponse(409, <String, Object?>{
        'code': 'printer_offline',
        'message': 'La impresora está desconectada.',
      });
    }

    item['state'] = 'printing';
    item['printer_id'] = printerId;
    final order = _orders[item['order_id'] as int];
    printer['state'] = 'printing';
    printer['progress'] = 0.0;
    printer['remaining_seconds'] =
        ((item['estimated_minutes'] as int?) ?? 0) * 60;
    printer['current_file'] =
        '${item['product_name'].toString().toLowerCase().replaceAll(' ', '_')}.gcode';
    printer['current_order'] = order == null
        ? null
        : <String, Object?>{
            'id': item['order_id'],
            'folio': order['folio'],
            'customer_name': _customerName(order['customer_id'] as int),
            'promised_date': order['promised_date'],
          };

    final job = _newJob(item, printer, state: 'printing');
    _jobs.add(job);
    return MockResponse(201, job);
  }

  MockResponse _completeJob(int jobId) {
    final job = _jobById(jobId);
    if (job == null) return _jobNotFound();
    final item = _itemById(job['item_id'] as int?);
    final printer = _printerById(job['printer_id'] as int?);
    job['state'] = 'printed';
    job['finished_at'] = _now();
    if (item != null) {
      item['state'] = 'printed';
      item['printed_quantity'] = item['quantity'];
      item['missing_quantity'] = 0;
    }
    _idlePrinter(printer);
    return MockResponse(200, job);
  }

  MockResponse _failJob(int jobId, Object? body) {
    final job = _jobById(jobId);
    if (job == null) return _jobNotFound();
    final map = body is Map ? body : const <String, Object?>{};
    final item = _itemById(job['item_id'] as int?);
    final printer = _printerById(job['printer_id'] as int?);
    job['state'] = 'failed';
    job['finished_at'] = _now();
    job['failure_reason'] = (map['reason'] as String?) ?? 'Sin motivo indicado';
    if (item != null) item['state'] = 'failed';
    _idlePrinter(printer);
    return MockResponse(200, job);
  }

  MockResponse _reprintJob(int jobId) {
    final job = _jobById(jobId);
    if (job == null) return _jobNotFound();
    final item = _itemById(job['item_id'] as int?);
    final printer = _printerById(job['printer_id'] as int?);
    if (item == null || printer == null) return _jobNotFound();
    item['state'] = 'queued';
    final newJob = _newJob(item, printer, state: 'queued');
    _jobs.add(newJob);
    return MockResponse(201, newJob);
  }

  Map<String, Object?> _newJob(
    Map<String, Object?> item,
    Map<String, Object?> printer, {
    required String state,
  }) => <String, Object?>{
    'id': _nextJobId++,
    'item_id': item['id'],
    'printer_id': printer['id'],
    'printer_name': printer['name'],
    'state': state,
    'started_at': state == 'printing' ? _now() : null,
    'finished_at': null,
    'grams_real': null,
    'minutes_real': null,
    'failure_reason': null,
    'current_file': null,
  };

  void _idlePrinter(Map<String, Object?>? printer) {
    if (printer == null) return;
    printer['state'] = 'idle';
    printer['progress'] = null;
    printer['remaining_seconds'] = null;
    printer['current_file'] = null;
    printer['current_order'] = null;
  }

  MockResponse _jobNotFound() => const MockResponse(404, <String, Object?>{
    'code': 'not_found',
    'message': 'Job no encontrado.',
  });

  // --- P-07 / P-08 / P-09: pedidos ----------------------------------------

  MockResponse _listOrders(Map<String, dynamic> query) {
    final status = query['status']?.toString();
    final customerId = int.tryParse('${query['customer_id'] ?? ''}');
    final dueBefore = _parseDate(query['due_before']?.toString());
    final search = query['q']?.toString().toLowerCase();

    final summaries = <Map<String, Object?>>[];
    for (final id in _orders.keys) {
      final summary = _buildOrderSummary(id);
      if (status != null && summary['status'] != status) continue;
      if (customerId != null && _orders[id]!['customer_id'] != customerId) {
        continue;
      }
      final promised = _parseDate(summary['promised_date']?.toString());
      if (dueBefore != null &&
          (promised == null || promised.isAfter(dueBefore))) {
        continue;
      }
      if (search != null && search.isNotEmpty) {
        final folio = '${summary['folio']}'.toLowerCase();
        final name = '${summary['customer_name']}'.toLowerCase();
        if (!folio.contains(search) && !name.contains(search)) continue;
      }
      summaries.add(summary);
    }
    summaries.sort((a, b) {
      final da = _parseDate(a['promised_date']?.toString());
      final db = _parseDate(b['promised_date']?.toString());
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return da.compareTo(db);
    });
    return MockResponse(200, summaries);
  }

  MockResponse _getOrder(int orderId) {
    if (!_orders.containsKey(orderId)) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Pedido no encontrado.',
      });
    }
    return MockResponse(200, _buildOrderDetail(orderId));
  }

  MockResponse _updateOrderStatus(int orderId, Object? body) {
    final order = _orders[orderId];
    if (order == null) {
      return const MockResponse(404, <String, Object?>{
        'code': 'not_found',
        'message': 'Pedido no encontrado.',
      });
    }
    final map = body is Map ? body : const <String, Object?>{};
    final next = map['status']?.toString();
    final previous = _buildOrderSummary(orderId)['status'] as String;
    order['manual_status'] = next;
    final history = order['history']! as List<Object?>;
    history.add(_h(next ?? previous, previous, _now(), 'Operador Demo'));
    return MockResponse(200, _buildOrderDetail(orderId));
  }

  MockResponse _createOrder(Object? body) {
    final map = body is Map ? body : const <String, Object?>{};
    final rawItems = (map['items'] as List?) ?? const <Object?>[];
    if (rawItems.isEmpty) {
      return const MockResponse(422, <String, Object?>{
        'code': 'invalid_order',
        'message': 'El pedido necesita al menos un item.',
      });
    }

    final customer = _resolveCustomer(map);
    final orderId = _nextOrderId++;
    final folio = 'NL-$orderId';
    final promised = map['promised_date']?.toString();
    final items = rawItems.whereType<Map<dynamic, dynamic>>().toList();

    var computedTotal = 0.0;
    final discarded = <int>[];
    for (final raw in items) {
      final product = _productById(raw['product_id'] as int?);
      if (product == null) {
        discarded.add(raw['product_id'] as int? ?? -1);
        continue;
      }
      final qty = (raw['quantity'] as int?) ?? 1;
      computedTotal += (product['base_price'] as num).toDouble() * qty;
      final itemId = _nextItemId++;
      _queueItems.add(
        _item(
          id: itemId,
          orderId: orderId,
          productId: product['id']! as int,
          product: product['name']! as String,
          color: (raw['color'] as String?) ?? product['color'] as String? ?? '',
          qty: qty,
          printed: 0,
          state: 'pending',
          printerId: null,
          position: _nextPosition(null),
          minutes: (product['estimated_minutes'] as int?) ?? 0,
          promised: promised,
        ),
      );
    }
    if (discarded.isNotEmpty) {
      return MockResponse(422, <String, Object?>{
        'code': 'invalid_product',
        'message': 'Producto(s) inexistente(s): $discarded',
      });
    }

    _orders[orderId] = _order(
      folio: folio,
      customerId: customer['id']! as int,
      promised: promised,
      total: (map['total'] as num?)?.toDouble() ?? computedTotal,
      notes: map['notes'] as String?,
      history: <Map<String, Object?>>[
        _h('confirmed', null, _now(), 'Operador Demo'),
      ],
    );
    return MockResponse(201, _buildOrderDetail(orderId));
  }

  Map<String, Object?> _resolveCustomer(Map<dynamic, dynamic> map) {
    final customerId = map['customer_id'] as int?;
    if (customerId != null) {
      final existing = _customers.where((c) => c['id'] == customerId).toList();
      if (existing.isNotEmpty) return existing.first;
    }
    final name = map['customer_name'] as String?;
    if (name != null && name.trim().isNotEmpty) {
      final existing = _customers
          .where(
            (c) => c['name'] == name && map['customer_phone'] == c['phone'],
          )
          .toList();
      if (existing.isNotEmpty) return existing.first;
      final created = _customer(
        _nextCustomerId++,
        name,
        (map['customer_phone'] as String?) ?? '',
        '',
      );
      _customers.add(created);
      return created;
    }
    return _customers.first;
  }

  Map<String, Object?> _buildOrderSummary(int orderId) {
    final order = _orders[orderId]!;
    final items = _queueItems.where((i) => i['order_id'] == orderId).toList();
    final itemsCount = items.fold<int>(
      0,
      (sum, i) => sum + (i['quantity'] as int? ?? 0),
    );
    final printedCount = items.fold<int>(
      0,
      (sum, i) => sum + (i['printed_quantity'] as int? ?? 0),
    );
    return <String, Object?>{
      'id': orderId,
      'folio': order['folio'],
      'customer_name': _customerName(order['customer_id'] as int),
      'status': _deriveStatus(order, items),
      'promised_date': order['promised_date'],
      'due_state': _dueState(order['promised_date']?.toString()),
      'total': order['total'],
      'items_count': itemsCount,
      'printed_count': printedCount,
      'created_at': order['created_at'],
    };
  }

  Map<String, Object?> _buildOrderDetail(int orderId) {
    final order = _orders[orderId]!;
    final summary = _buildOrderSummary(orderId);
    final items = _queueItems
        .where((i) => i['order_id'] == orderId)
        .map(_orderItem)
        .toList();
    final customerId = order['customer_id'] as int;
    final customerRow = _firstWhereOrNull(
      _customers,
      (c) => c['id'] == customerId,
    );
    final customer = customerRow == null
        ? null
        : <String, Object?>{
            'id': customerRow['id'],
            'name': customerRow['name'],
            'phone': customerRow['phone'],
            'email': customerRow['email'],
            'notes': customerRow['notes'],
          };
    return <String, Object?>{
      ...summary,
      'tracking_token': order['tracking_token'],
      'notes': order['notes'],
      'customer': customer,
      'items': items,
      'history': order['history'],
      'shipment': order['shipment'],
    };
  }

  Map<String, Object?> _orderItem(Map<String, Object?> item) {
    final printerId = item['printer_id'] as int?;
    return <String, Object?>{
      'id': item['id'],
      'product_id': item['product_id'],
      'product_name': item['product_name'],
      'color': item['color'],
      'quantity': item['quantity'],
      'printed_quantity': item['printed_quantity'],
      'missing_quantity': item['missing_quantity'],
      'state': item['state'],
      'printer_id': printerId,
      'printer_name': printerId == null ? null : _printerName(printerId),
    };
  }

  String _deriveStatus(
    Map<String, Object?> order,
    List<Map<String, Object?>> items,
  ) {
    const manual = <String>{'packed', 'shipped', 'delivered', 'cancelled'};
    final manualStatus = order['manual_status']?.toString();
    if (manualStatus != null && manual.contains(manualStatus)) {
      return manualStatus;
    }
    if (items.isEmpty) return 'confirmed';
    if (items.every((i) => i['state'] == 'printed')) return 'printed';
    if (items.any((i) => i['state'] == 'printing')) return 'printing';
    if (items.any((i) => i['state'] == 'queued' || i['state'] == 'printing')) {
      return 'queued';
    }
    return 'confirmed';
  }

  String _dueState(String? promised) {
    final date = _parseDate(promised);
    if (date == null) return 'none';
    final diff = date.difference(kMockToday).inDays;
    if (diff < 0) return 'overdue';
    if (diff <= kMockDueSoonDays) return 'due_soon';
    return 'ok';
  }

  // --- helpers -------------------------------------------------------------

  Map<String, Object?>? _printerById(int? id) =>
      _firstWhereOrNull(_printers, (p) => p['id'] == id);

  Map<String, Object?>? _itemById(int? id) =>
      _firstWhereOrNull(_queueItems, (i) => i['id'] == id);

  Map<String, Object?>? _jobById(int? id) =>
      _firstWhereOrNull(_jobs, (j) => j['id'] == id);

  Map<String, Object?>? _productById(int? id) =>
      _firstWhereOrNull(_products, (p) => p['id'] == id);

  static Map<String, Object?>? _firstWhereOrNull(
    List<Map<String, Object?>> list,
    bool Function(Map<String, Object?>) test,
  ) {
    for (final entry in list) {
      if (test(entry)) return entry;
    }
    return null;
  }

  String _printerName(int id) =>
      (_printerById(id)?['name'] ?? 'Impresora $id').toString();

  String _customerName(int id) =>
      (_firstWhereOrNull(_customers, (c) => c['id'] == id)?['name'] ??
              'Cliente $id')
          .toString();

  int _byPromisedDate(Map<String, Object?> a, Map<String, Object?> b) {
    final da = _parseDate(a['promised_date']?.toString());
    final db = _parseDate(b['promised_date']?.toString());
    if (da == null && db == null) return 0;
    if (da == null) return 1;
    if (db == null) return -1;
    return da.compareTo(db);
  }

  static DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  static String _now() => DateTime.now().toUtc().toIso8601String();

  /// Avanza la simulación en vivo (P-02).
  ///
  /// Suma progreso y descuenta tiempo a la impresora que está imprimiendo y
  /// devuelve su id, o `null` si ninguna cambió. La usa el cliente en tiempo
  /// real simulado para provocar refrescos.
  int? tick() {
    for (final printer in _printers) {
      if (printer['state'] != 'printing') continue;
      final progress = (printer['progress'] as num?)?.toDouble() ?? 0;
      final remaining = (printer['remaining_seconds'] as int?) ?? 0;
      final next = (progress + 2.5).clamp(0, 100).toDouble();
      printer['progress'] = next;
      printer['remaining_seconds'] = (remaining - 30).clamp(0, remaining);
      if (next >= 100) {
        printer['state'] = 'idle';
        printer['progress'] = null;
        printer['remaining_seconds'] = null;
        printer['current_file'] = null;
        printer['current_order'] = null;
      }
      return printer['id'] as int;
    }
    return null;
  }
}
