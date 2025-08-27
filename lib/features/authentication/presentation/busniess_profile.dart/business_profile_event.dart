enum BusinessProfileEventType { idle, loading, failure, success }

class BusinessProfileEvent {
  final BusinessProfileEventType type;
  final String? message;
  final dynamic data;

  const BusinessProfileEvent._(this.type, {this.message, this.data});

  const BusinessProfileEvent.idle() : this._(BusinessProfileEventType.idle);
  const BusinessProfileEvent.loading([String? msg])
      : this._(BusinessProfileEventType.loading, message: msg);
  const BusinessProfileEvent.success()
      : this._(BusinessProfileEventType.success);
  const BusinessProfileEvent.failure(String msg)
      : this._(BusinessProfileEventType.failure, message: msg);
}
