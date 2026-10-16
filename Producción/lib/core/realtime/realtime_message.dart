/// Mensaje recibido por el canal de tiempo real `/ws` (doc §2).
///
/// El backend publica eventos `StatusEvent` (ver `packages/api-contract`).
/// La app solo necesita saber qué entidad cambió para refrescar la vista; no
/// interpreta lógica de negocio (esa vive en el backend).
class RealtimeMessage {
  const RealtimeMessage({
    required this.type,
    required this.entity,
    this.entityId,
    this.payload = const <String, Object?>{},
  });

  factory RealtimeMessage.fromJson(Map<String, Object?> json) {
    final rawId = json['entity_id'];
    final rawPayload = json['payload'];
    return RealtimeMessage(
      type: (json['type'] as String?) ?? 'unknown',
      entity: (json['entity'] as String?) ?? 'unknown',
      entityId: rawId is int ? rawId : int.tryParse('$rawId'),
      payload: rawPayload is Map
          ? rawPayload.cast<String, Object?>()
          : const <String, Object?>{},
    );
  }

  /// Tipo de evento, p. ej. `printer.state`, `queue.updated`.
  final String type;

  /// Entidad afectada: `printer`, `queue`, `order`…
  final String entity;

  /// Identificador de la entidad, si aplica.
  final int? entityId;

  /// Datos del evento (delta; no se usa como fuente de verdad).
  final Map<String, Object?> payload;

  @override
  String toString() => 'RealtimeMessage($type, $entity, $entityId)';
}
