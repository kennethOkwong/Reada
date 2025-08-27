import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';

enum ForgotPasswordEventType { idle, loading, failure, success, navigateToVery }

class ForgotPasswordEvent {
  final ForgotPasswordEventType type;
  final String? message;
  final dynamic data;

  const ForgotPasswordEvent._(this.type, {this.message, this.data});

  const ForgotPasswordEvent.idle() : this._(ForgotPasswordEventType.idle);
  const ForgotPasswordEvent.loading([String? msg])
      : this._(ForgotPasswordEventType.loading, message: msg);
  const ForgotPasswordEvent.success() : this._(ForgotPasswordEventType.success);
  const ForgotPasswordEvent.navigateToVery(SendCodeRequestDto data)
      : this._(ForgotPasswordEventType.navigateToVery, data: data);
  const ForgotPasswordEvent.failure([String? msg])
      : this._(ForgotPasswordEventType.failure, message: msg);
}
