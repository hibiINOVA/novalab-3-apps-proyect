// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrinterState _$idle = const PrinterState._('idle');
const PrinterState _$printing = const PrinterState._('printing');
const PrinterState _$paused = const PrinterState._('paused');
const PrinterState _$offline = const PrinterState._('offline');
const PrinterState _$error = const PrinterState._('error');

PrinterState _$valueOf(String name) {
  switch (name) {
    case 'idle':
      return _$idle;
    case 'printing':
      return _$printing;
    case 'paused':
      return _$paused;
    case 'offline':
      return _$offline;
    case 'error':
      return _$error;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PrinterState> _$values =
    BuiltSet<PrinterState>(const <PrinterState>[
  _$idle,
  _$printing,
  _$paused,
  _$offline,
  _$error,
]);

class _$PrinterStateMeta {
  const _$PrinterStateMeta();
  PrinterState get idle => _$idle;
  PrinterState get printing => _$printing;
  PrinterState get paused => _$paused;
  PrinterState get offline => _$offline;
  PrinterState get error => _$error;
  PrinterState valueOf(String name) => _$valueOf(name);
  BuiltSet<PrinterState> get values => _$values;
}

abstract class _$PrinterStateMixin {
  // ignore: non_constant_identifier_names
  _$PrinterStateMeta get PrinterState => const _$PrinterStateMeta();
}

Serializer<PrinterState> _$printerStateSerializer = _$PrinterStateSerializer();

class _$PrinterStateSerializer implements PrimitiveSerializer<PrinterState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'idle': 'idle',
    'printing': 'printing',
    'paused': 'paused',
    'offline': 'offline',
    'error': 'error',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'idle': 'idle',
    'printing': 'printing',
    'paused': 'paused',
    'offline': 'offline',
    'error': 'error',
  };

  @override
  final Iterable<Type> types = const <Type>[PrinterState];
  @override
  final String wireName = 'PrinterState';

  @override
  Object serialize(Serializers serializers, PrinterState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrinterState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrinterState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
