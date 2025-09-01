import 'package:reada/features/authentication/domain/entities/user.dart';

enum StoreEventType { idle, loading, failure, success }

class StoreEvent {
  final StoreEventType type;
  final String? message;
  final User? user;

  const StoreEvent._(this.type, {this.message, this.user});

  const StoreEvent.idle() : this._(StoreEventType.idle);
  const StoreEvent.loading([String? msg])
      : this._(StoreEventType.loading, message: msg);
  const StoreEvent.success(User userData)
      : this._(StoreEventType.success, user: userData);
  const StoreEvent.failure(String msg)
      : this._(StoreEventType.failure, message: msg);
}
