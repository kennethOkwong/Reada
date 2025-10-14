import 'package:reada/features/authentication/domain/entities/user.dart';

enum OrderEventType { idle, loading, failure, success }

class OrderEvent {
  final OrderEventType type;
  final String? message;
  final User? user;

  const OrderEvent._(this.type, {this.message, this.user});

  const OrderEvent.idle() : this._(OrderEventType.idle);
  const OrderEvent.loading([String? msg])
      : this._(OrderEventType.loading, message: msg);
  const OrderEvent.success(User userData)
      : this._(OrderEventType.success, user: userData);
  const OrderEvent.failure(String msg)
      : this._(OrderEventType.failure, message: msg);
}
