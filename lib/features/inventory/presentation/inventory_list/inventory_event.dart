import 'package:reada/features/authentication/domain/entities/user.dart';

enum InventoryEventType { idle, loading, failure, success }

class InventoryEvent {
  final InventoryEventType type;
  final String? message;
  final User? user;

  const InventoryEvent._(this.type, {this.message, this.user});

  const InventoryEvent.idle() : this._(InventoryEventType.idle);
  const InventoryEvent.loading([String? msg])
      : this._(InventoryEventType.loading, message: msg);
  const InventoryEvent.success(User userData)
      : this._(InventoryEventType.success, user: userData);
  const InventoryEvent.failure(String msg)
      : this._(InventoryEventType.failure, message: msg);
}
