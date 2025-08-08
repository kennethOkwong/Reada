enum VerifyCodeEventType { idle, loading, failure, success }

class VerifyCodeEvent {
  final VerifyCodeEventType type;
  final String? message;

  const VerifyCodeEvent._(this.type, {this.message});

  const VerifyCodeEvent.idle() : this._(VerifyCodeEventType.idle);
  const VerifyCodeEvent.loading([String? msg])
      : this._(VerifyCodeEventType.loading, message: msg);
  const VerifyCodeEvent.success() : this._(VerifyCodeEventType.success);
  const VerifyCodeEvent.failure([String? msg])
      : this._(VerifyCodeEventType.failure, message: msg);
}
