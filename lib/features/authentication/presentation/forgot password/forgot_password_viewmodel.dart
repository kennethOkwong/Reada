import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_event.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class ForgotPasswordViewmodel extends BaseViewModel<ForgotPasswordEvent> {
  SendCodeRequestDto codeModel = SendCodeRequestDto(
    codeType: CodeType.passwordReset.readableName,
  );
  ResetPasswordRequestDto passwordResetModel = ResetPasswordRequestDto.empty();

  void init(String email) {
    passwordResetModel = passwordResetModel.copyWith(email: email);
  }

  void onEmailChanged(String? value) {
    codeModel = codeModel.copyWith(email: value);
  }

  void onPasswordChanged(String? value) {
    passwordResetModel = passwordResetModel.copyWith(password: value);
  }

  void onCPasswordChanged(String? value) {
    passwordResetModel = passwordResetModel.copyWith(cPassword: value);
  }

  Future<void> sendCode() async {
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
  }

  Future<void> resetPassword() async {
    startLoader();
    var result = await resetPasswordUseCase.call(passwordResetModel);
    stopLoader();
    result.when(
      success: (data) {
        emitEvent(const ForgotPasswordEvent.success());
      },
      failure: (message) {
        emitEvent(ForgotPasswordEvent.failure(message));
      },
    );
  }
}
