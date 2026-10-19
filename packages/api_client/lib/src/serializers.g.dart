// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add($OrderSummary.serializer)
      ..add(Branding.serializer)
      ..add(Customer.serializer)
      ..add(CustomerCreateRequest.serializer)
      ..add(DueState.serializer)
      ..add(Error.serializer)
      ..add(ItemState.serializer)
      ..add(JoinOrganizationRequest.serializer)
      ..add(LoginRequest.serializer)
      ..add(LoginResponse.serializer)
      ..add(MembershipStatus.serializer)
      ..add(OrderCreateRequest.serializer)
      ..add(OrderDetail.serializer)
      ..add(OrderItem.serializer)
      ..add(OrderItemInput.serializer)
      ..add(OrderRef.serializer)
      ..add(OrderStatus.serializer)
      ..add(OrderStatusUpdateRequest.serializer)
      ..add(Organization.serializer)
      ..add(OrganizationCreateRequest.serializer)
      ..add(OrganizationMember.serializer)
      ..add(OrganizationUpdateRequest.serializer)
      ..add(PrintJob.serializer)
      ..add(PrintJobFailRequest.serializer)
      ..add(PrintJobStartRequest.serializer)
      ..add(Printer.serializer)
      ..add(PrinterConnectionTest.serializer)
      ..add(PrinterConnectionTestRequest.serializer)
      ..add(PrinterCreateRequest.serializer)
      ..add(PrinterState.serializer)
      ..add(PrinterUpdateRequest.serializer)
      ..add(Product.serializer)
      ..add(PublicLookupRequest.serializer)
      ..add(PublicLookupResponse.serializer)
      ..add(Queue.serializer)
      ..add(QueueAcceptEntry.serializer)
      ..add(QueueAcceptRequest.serializer)
      ..add(QueueItem.serializer)
      ..add(QueueItemState.serializer)
      ..add(QueueReorderEntry.serializer)
      ..add(QueueReorderRequest.serializer)
      ..add(QueueSuggestion.serializer)
      ..add(RefreshRequest.serializer)
      ..add(RegisterRequest.serializer)
      ..add(Role.serializer)
      ..add(Shipment.serializer)
      ..add(SpoolRef.serializer)
      ..add(StatusEvent.serializer)
      ..add(StatusHistoryEntry.serializer)
      ..add(SuggestionAssignment.serializer)
      ..add(User.serializer)
      ..add(UserOrganizationStatus.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(OrderItemInput)]),
          () => ListBuilder<OrderItemInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(QueueAcceptEntry)]),
          () => ListBuilder<QueueAcceptEntry>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(QueueItem)]),
          () => ListBuilder<QueueItem>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(QueueItem)])
          ]),
          () => MapBuilder<String, BuiltList<QueueItem>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(QueueReorderEntry)]),
          () => ListBuilder<QueueReorderEntry>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(StatusHistoryEntry)]),
          () => ListBuilder<StatusHistoryEntry>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(OrderItem)]),
          () => ListBuilder<OrderItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(SuggestionAssignment)]),
          () => ListBuilder<SuggestionAssignment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => MapBuilder<String, JsonObject?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
