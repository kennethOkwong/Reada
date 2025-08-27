import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/register_view/register_event.dart';

class RegisterViewmodel extends BaseViewModel<RegisterEvent> {
  RegisterRequestDto data = RegisterRequestDto.empty();
  int currentStep = 0;
  bool isForward = true;

  void goForward() {
    isForward = true;
    currentStep = 1;
    notifyListeners();
  }

  void goBackward() {
    isForward = false;
    currentStep = 0;
    notifyListeners();
  }

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

  Future<void> register() async {
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
  }
}
