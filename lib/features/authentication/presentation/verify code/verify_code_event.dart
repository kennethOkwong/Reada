enum VerifyCodeEventType {
  idle,
  loading,
  verifyFailure,
  verifySuccess,
  resendFailure,
  resendSuccess
}

class VerifyCodeEvent {
  final VerifyCodeEventType type;
  final String? message;

  const VerifyCodeEvent._(this.type, {this.message});

  const VerifyCodeEvent.idle() : this._(VerifyCodeEventType.idle);
  const VerifyCodeEvent.loading([String? msg])
      : this._(VerifyCodeEventType.loading, message: msg);
  const VerifyCodeEvent.verifySuccess()
      : this._(VerifyCodeEventType.verifySuccess);
  const VerifyCodeEvent.verifyFailure(String msg)
      : this._(VerifyCodeEventType.verifyFailure, message: msg);
  const VerifyCodeEvent.resendSuccess()
      : this._(VerifyCodeEventType.resendSuccess);
  const VerifyCodeEvent.resendFailure(String msg)
      : this._(VerifyCodeEventType.resendFailure, message: msg);
}
