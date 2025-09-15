import 'package:reada/features/authentication/domain/entities/user.dart';

enum LoginEventType { idle, loading, failure, success }

class LoginEvent {
  final LoginEventType type;
  final String? message;
  final User? user;

  const LoginEvent._(this.type, {this.message, this.user});

  const LoginEvent.idle() : this._(LoginEventType.idle);
  const LoginEvent.loading([String? msg])
      : this._(LoginEventType.loading, message: msg);
  const LoginEvent.success(User userData)
      : this._(LoginEventType.success, user: userData);
  const LoginEvent.failure(String msg)
      : this._(LoginEventType.failure, message: msg);
}
