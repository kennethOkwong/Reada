enum LoginEventType { idle, loading, failure, success }

class LoginEvent {
  final LoginEventType type;
  final String? message;

  const LoginEvent._(this.type, {this.message});

  const LoginEvent.idle() : this._(LoginEventType.idle);
  const LoginEvent.loading([String? msg])
      : this._(LoginEventType.loading, message: msg);
  const LoginEvent.success() : this._(LoginEventType.success);
  const LoginEvent.failure([String? msg])
      : this._(LoginEventType.failure, message: msg);
}
