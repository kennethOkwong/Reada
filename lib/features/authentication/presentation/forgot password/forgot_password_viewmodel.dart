import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_event.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class ForgotPasswordViewmodel extends BaseViewModel<ForgotPasswordEvent, void> {
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
    setLoading();
    var result = await sendCodeUseCase.call(codeModel);
    setIdle();
    result.when(
      success: (data, message) {
        emitEvent(ForgotPasswordEvent.navigateToVery(codeModel));
      },
      failure: (exception) {
        emitEvent(ForgotPasswordEvent.failure(exception.toString()));
      },
    );
  }

  Future<void> resetPassword() async {
    setLoading();
    var result = await resetPasswordUseCase.call(passwordResetModel);
    setIdle();
    result.when(
      success: (data, message) {
        emitEvent(const ForgotPasswordEvent.success());
      },
      failure: (exception) {
        emitEvent(ForgotPasswordEvent.failure(exception.toString()));
      },
    );
  }
}
