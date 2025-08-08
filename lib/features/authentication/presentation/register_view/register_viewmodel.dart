import 'dart:developer';
import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/domain/entities/register_user_model.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/register_view/register_event.dart';
import 'package:reada/shared/enums/verification_type_enum.dart';

class RegisterViewmodel extends BaseViewModel<RegisterEvent> {
  RegisterUserDataModel data = RegisterUserDataModel.empty();

  void onFisrtNameChanged(String? value) {
    data = data.copyWith(firstName: value);
  }

  void onLastNameChanged(String? value) {
    data = data.copyWith(lastName: value);
  }

  void onEmailChanged(String? value) {
    data = data.copyWith(email: value);
  }

  void onPhoneChanged(String? value) {
    data = data.copyWith(phone: value);
  }

  void onPasswordChanged(String? value) {
    data = data.copyWith(password: value);
  }

  void onConfirmPasswordChanged(String? value) {
    data = data.copyWith(confirmPassword: value);
  }

  SendCodeDataModel get codeModel => SendCodeDataModel(
        email: data.email!,
        codeType: CodeType.userVerification.readableName,
      );

  Future<void> sendCode() async {
    try {
      startLoader();
      await sendCodeUseCase.call(codeModel);
      stopLoader();
    } catch (error, s) {
      log(error.toString(), stackTrace: s);
      stopLoader();
    }
  }

  Future<void> register() async {
    try {
      startLoader();
      var result = await registerUseCase.call(data);
      stopLoader();
      result.when(
        success: (data) {
          emitEvent(const RegisterEvent.success());
        },
        failure: (message) {
          emitEvent(RegisterEvent.failure(message));
        },
      );
    } catch (error, s) {
      log(error.toString(), stackTrace: s);
      stopLoader();
      emitEvent(const RegisterEvent.failure('An error occured'));
    }
  }
}
