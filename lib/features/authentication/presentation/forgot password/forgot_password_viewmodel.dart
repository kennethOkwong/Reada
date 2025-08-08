import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/domain/entities/reset_password_data_model.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_event.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class ForgotPasswordViewmodel extends BaseViewModel<ForgotPasswordEvent> {
  final codeModel =
      SendCodeDataModel(codeType: CodeType.passwordReset.readableName);
  final passwordResetModel = ResetPasswordDataModel();

  void onEmailChanged(String? value) {
    codeModel.email = value;
  }

  void onPasswordChanged(String? value) {
    passwordResetModel.password = value;
  }

  Future<void> sendCode() async {
    try {
      startLoader();
      var result = await sendCodeUseCase.call(codeModel);
      stopLoader();
      result.when(
        success: (data) {
          emitEvent(ForgotPasswordEvent.navigateToVery(codeModel));
        },
        failure: (message) {
          emitEvent(ForgotPasswordEvent.failure(message));
        },
      );

      return;
    } catch (error) {
      stopLoader();
      emitEvent(const ForgotPasswordEvent.failure());
      return;
    }
  }

  Future<void> resetPassword(String email) async {
    passwordResetModel.email = email;
    try {
      startLoader();
      var response =
          await authRepository.resetPassword(data: passwordResetModel);
      stopLoader();
      if (response.isSuccessful) {
        emitEvent(const ForgotPasswordEvent.success());
        return;
      }
      emitEvent(ForgotPasswordEvent.failure(response.message));
    } catch (error) {
      stopLoader();
      emitEvent(const ForgotPasswordEvent.failure());
    }
  }
}
