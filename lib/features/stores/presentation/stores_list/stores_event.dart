import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';

enum StoreEventType {
  idle,
  loading,
  failure,
  success,
  storeAdded,
  storesFetched,
  bookcaseAdded,
  bookcasesFetched,
  shelvesFetched,
  bookDetailsFetched,
}

class StoreEvent {
  final StoreEventType type;
  final String? message;

  final BookcaseDto? bookcase;
  final List<BookcaseDto>? bookcases;

  const StoreEvent._(
    this.type, {
    this.message,
    this.bookcase,
    this.bookcases,
  });

  /// Default states
  const StoreEvent.idle() : this._(StoreEventType.idle);
  const StoreEvent.loading([String? msg])
      : this._(StoreEventType.loading, message: msg);
  const StoreEvent.failure(String msg)
      : this._(StoreEventType.failure, message: msg);

  /// Success states
  const StoreEvent.success([String? msg])
      : this._(StoreEventType.success, message: msg);

  /// Specific domain events
  const StoreEvent.storeAdded() : this._(StoreEventType.storeAdded);
  const StoreEvent.storesFetched() : this._(StoreEventType.storesFetched);

  const StoreEvent.bookcaseAdded() : this._(StoreEventType.bookcaseAdded);
  const StoreEvent.bookcasesFetched() : this._(StoreEventType.bookcasesFetched);

  const StoreEvent.shelvesFetched() : this._(StoreEventType.shelvesFetched);

  const StoreEvent.bookDetailsFetched()
      : this._(StoreEventType.bookDetailsFetched);
}
