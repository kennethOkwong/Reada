import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';

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
  const ForgotPasswordEvent.navigateToVery(SendCodeDataModel data)
      : this._(ForgotPasswordEventType.navigateToVery, data: data);
  const ForgotPasswordEvent.failure([String? msg])
      : this._(ForgotPasswordEventType.failure, message: msg);
}
