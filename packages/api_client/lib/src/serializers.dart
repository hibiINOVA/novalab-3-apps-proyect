//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:novalab_api/src/date_serializer.dart';
import 'package:novalab_api/src/model/date.dart';

import 'package:novalab_api/src/model/branding.dart';
import 'package:novalab_api/src/model/error.dart';
import 'package:novalab_api/src/model/login_request.dart';
import 'package:novalab_api/src/model/login_response.dart';
import 'package:novalab_api/src/model/order_ref.dart';
import 'package:novalab_api/src/model/printer.dart';
import 'package:novalab_api/src/model/printer_state.dart';
import 'package:novalab_api/src/model/queue.dart';
import 'package:novalab_api/src/model/queue_item.dart';
import 'package:novalab_api/src/model/queue_item_state.dart';
import 'package:novalab_api/src/model/queue_reorder_entry.dart';
import 'package:novalab_api/src/model/queue_reorder_request.dart';
import 'package:novalab_api/src/model/refresh_request.dart';
import 'package:novalab_api/src/model/role.dart';
import 'package:novalab_api/src/model/spool_ref.dart';
import 'package:novalab_api/src/model/status_event.dart';
import 'package:novalab_api/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  Branding,
  Error,
  LoginRequest,
  LoginResponse,
  OrderRef,
  Printer,
  PrinterState,
  Queue,
  QueueItem,
  QueueItemState,
  QueueReorderEntry,
  QueueReorderRequest,
  RefreshRequest,
  Role,
  SpoolRef,
  StatusEvent,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Printer)]),
        () => ListBuilder<Printer>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
