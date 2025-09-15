enum BusinessProfileEventType {
  idle,
  loading,
  failure,
  navigateToLogin,
  navigateToDashborad
}

class BusinessProfileEvent {
  final BusinessProfileEventType type;
  final String? message;
  final dynamic data;

  const BusinessProfileEvent._(this.type, {this.message, this.data});

  const BusinessProfileEvent.idle() : this._(BusinessProfileEventType.idle);
  const BusinessProfileEvent.loading([String? msg])
      : this._(BusinessProfileEventType.loading, message: msg);
  const BusinessProfileEvent.navigateToDashborad()
      : this._(BusinessProfileEventType.navigateToDashborad);
  const BusinessProfileEvent.navigateToLogin()
      : this._(BusinessProfileEventType.navigateToLogin);
  const BusinessProfileEvent.failure(String msg)
      : this._(BusinessProfileEventType.failure, message: msg);
}
