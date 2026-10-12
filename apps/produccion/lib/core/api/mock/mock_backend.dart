/// Backend simulado en memoria para desarrollar la app sin el backend real.
///
/// Devuelve estructuras JSON que respetan el contrato
/// `packages/api-contract/openapi.yaml`. Se elimina cuando el backend FastAPI
/// exista (ver AGENTS.md, handoff).
library;

import 'dart:convert';

/// Credenciales de demostración aceptadas por el mock.
const String kMockPassword = 'novalab';
const String kMockOwnerEmail = 'dueno@novalab.mx';
const String kMockOperatorEmail = 'operador@novalab.mx';

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
  late List<Map<String, Object?>> _printers;
  late List<Map<String, Object?>> _queueItems;

  void _reset() {
    _queueVersion = 1;
    _printers = <Map<String, Object?>>[
      <String, Object?>{
        'id': 1,
        'name': 'Impresora 1',
        'state': 'printing',
        'progress': 42.5,
        'remaining_seconds': 1800,
        'nozzle_temp': 209.4,
        'nozzle_target': 210.0,
        'bed_temp': 59.8,
        'bed_target': 60.0,
        'current_file': 'vaso_petg.gcode',
        'camera_available': true,
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
        'state': 'idle',
        'camera_available': true,
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
        'state': 'offline',
        'camera_available': false,
        'last_seen': null,
      },
    ];
    _queueItems = <Map<String, Object?>>[
      _item(
        id: 1,
        orderId: 1001,
        folio: 'NL-1001',
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
        folio: 'NL-1002',
        product: 'Base para celular',
        color: 'Blanco',
        qty: 1,
        printed: 0,
        state: 'queued',
        printerId: 2,
        position: 0,
        minutes: 95,
        promised: '2026-10-20',
      ),
      _item(
        id: 3,
        orderId: 1003,
        folio: 'NL-1003',
        product: 'Engrane',
        color: 'Blanco',
        qty: 8,
        printed: 0,
        state: 'queued',
        printerId: 2,
        position: 1,
        minutes: 40,
        promised: '2026-10-22',
      ),
      _item(
        id: 5,
        orderId: 1004,
        folio: 'NL-1004',
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
        folio: 'NL-1005',
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
  }

  static Map<String, Object?> _item({
    required int id,
    required int orderId,
    required String folio,
    required String product,
    required String color,
    required int qty,
    required int printed,
    required String state,
    required int? printerId,
    required int position,
    required int minutes,
    required String promised,
  }) {
    return <String, Object?>{
      'id': id,
      'order_id': orderId,
      'order_folio': folio,
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
  /// curso hacia el backend real.
  MockResponse? handle(String method, String path, Object? body) {
    final cameraMatch = RegExp(
      r'^/api/printers/(\d+)/camera/snapshot$',
    ).firstMatch(path);
    if (method == 'GET' && cameraMatch != null) {
      return _cameraSnapshot(int.parse(cameraMatch.group(1)!));
    }

    switch ('$method $path') {
      case 'POST /api/auth/login':
        return _login(body);
      case 'POST /api/auth/refresh':
        return _refresh(body);
      case 'GET /api/public/branding':
        return const MockResponse(200, _branding);
      case 'GET /api/printers':
        return MockResponse(200, _printers);
      case 'GET /api/queue':
        return MockResponse(200, _buildQueue());
      case 'PATCH /api/queue/reorder':
        return _reorder(body);
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
    return MockResponse(200, _loginResponse(isOperator));
  }

  MockResponse _refresh(Object? body) =>
      MockResponse(200, _loginResponse(false));

  Map<String, Object?> _loginResponse(bool operator) => <String, Object?>{
    'access_token': 'mock-access-${DateTime.now().millisecondsSinceEpoch}',
    'refresh_token': 'mock-refresh-token',
    'token_type': 'bearer',
    'user': <String, Object?>{
      'id': operator ? 2 : 1,
      'name': operator ? 'Operador Demo' : 'Dueño Demo',
      'email': operator ? kMockOperatorEmail : kMockOwnerEmail,
      'role': operator ? 'operator' : 'owner',
    },
  };

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

  MockResponse _cameraSnapshot(int printerId) {
    final match = _printers.where((p) => p['id'] == printerId).toList();
    if (match.isEmpty || match.first['camera_available'] != true) {
      return const MockResponse(404, <String, Object?>{
        'code': 'camera_unavailable',
        'message': 'La impresora no tiene cámara o aún no hay snapshot.',
      });
    }
    return MockResponse(
      200,
      base64Decode(kMockCameraPngBase64),
      contentType: 'image/png',
    );
  }

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
