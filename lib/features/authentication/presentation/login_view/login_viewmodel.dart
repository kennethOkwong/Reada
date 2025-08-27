import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/login_view/login_event.dart';

class LoginViewmodel extends BaseViewModel<LoginEvent> {
  LoginRequestDto data = LoginRequestDto.empty();

  void onEmailChanged(String? value) {
    data = data.copyWith(email: value);
  }

  void onPasswordChanged(String? value) {
    data = data.copyWith(password: value);
  }

  Future<void> login() async {
    startLoader();
    var result = await loginUseCase.call(data);
    stopLoader();
    result.when(
      success: (data) {
        emitEvent(const LoginEvent.success());
      },
      failure: (message) {
        emitEvent(LoginEvent.failure(message));
      },
    );
  }
}
