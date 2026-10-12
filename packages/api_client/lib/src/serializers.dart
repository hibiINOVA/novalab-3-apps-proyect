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
import 'package:novalab_api/src/model/customer.dart';
import 'package:novalab_api/src/model/due_state.dart';
import 'package:novalab_api/src/model/error.dart';
import 'package:novalab_api/src/model/item_state.dart';
import 'package:novalab_api/src/model/login_request.dart';
import 'package:novalab_api/src/model/login_response.dart';
import 'package:novalab_api/src/model/order_create_request.dart';
import 'package:novalab_api/src/model/order_detail.dart';
import 'package:novalab_api/src/model/order_item.dart';
import 'package:novalab_api/src/model/order_item_input.dart';
import 'package:novalab_api/src/model/order_ref.dart';
import 'package:novalab_api/src/model/order_status.dart';
import 'package:novalab_api/src/model/order_status_update_request.dart';
import 'package:novalab_api/src/model/order_summary.dart';
import 'package:novalab_api/src/model/print_job.dart';
import 'package:novalab_api/src/model/print_job_fail_request.dart';
import 'package:novalab_api/src/model/print_job_start_request.dart';
import 'package:novalab_api/src/model/printer.dart';
import 'package:novalab_api/src/model/printer_state.dart';
import 'package:novalab_api/src/model/product.dart';
import 'package:novalab_api/src/model/queue.dart';
import 'package:novalab_api/src/model/queue_accept_entry.dart';
import 'package:novalab_api/src/model/queue_accept_request.dart';
import 'package:novalab_api/src/model/queue_item.dart';
import 'package:novalab_api/src/model/queue_item_state.dart';
import 'package:novalab_api/src/model/queue_reorder_entry.dart';
import 'package:novalab_api/src/model/queue_reorder_request.dart';
import 'package:novalab_api/src/model/queue_suggestion.dart';
import 'package:novalab_api/src/model/refresh_request.dart';
import 'package:novalab_api/src/model/role.dart';
import 'package:novalab_api/src/model/shipment.dart';
import 'package:novalab_api/src/model/spool_ref.dart';
import 'package:novalab_api/src/model/status_event.dart';
import 'package:novalab_api/src/model/status_history_entry.dart';
import 'package:novalab_api/src/model/suggestion_assignment.dart';
import 'package:novalab_api/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  Branding,
  Customer,
  DueState,
  Error,
  ItemState,
  LoginRequest,
  LoginResponse,
  OrderCreateRequest,
  OrderDetail,
  OrderItem,
  OrderItemInput,
  OrderRef,
  OrderStatus,
  OrderStatusUpdateRequest,
  OrderSummary,
  $OrderSummary,
  PrintJob,
  PrintJobFailRequest,
  PrintJobStartRequest,
  Printer,
  PrinterState,
  Product,
  Queue,
  QueueAcceptEntry,
  QueueAcceptRequest,
  QueueItem,
  QueueItemState,
  QueueReorderEntry,
  QueueReorderRequest,
  QueueSuggestion,
  RefreshRequest,
  Role,
  Shipment,
  SpoolRef,
  StatusEvent,
  StatusHistoryEntry,
  SuggestionAssignment,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Printer)]),
        () => ListBuilder<Printer>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(OrderSummary)]),
        () => ListBuilder<OrderSummary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Product)]),
        () => ListBuilder<Product>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Customer)]),
        () => ListBuilder<Customer>(),
      )
      ..add(OrderSummary.serializer)
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
