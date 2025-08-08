enum RegisterEventType { idle, loading, failure, success }

class RegisterEvent {
  final RegisterEventType type;
  final String? message;
  final dynamic data;

  const RegisterEvent._(this.type, {this.message, this.data});

  const RegisterEvent.idle() : this._(RegisterEventType.idle);
  const RegisterEvent.loading([String? msg])
      : this._(RegisterEventType.loading, message: msg);
  const RegisterEvent.success() : this._(RegisterEventType.success);
  const RegisterEvent.failure(String msg)
      : this._(RegisterEventType.failure, message: msg);
}
