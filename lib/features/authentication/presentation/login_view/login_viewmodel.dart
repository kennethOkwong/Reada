import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/domain/entities/login_data_model.dart';
import 'package:reada/features/authentication/presentation/login_view/login_event.dart';

class LoginViewmodel extends BaseViewModel<LoginEvent> {
  final data = LoginDataModel();

  void onEmailChanged(String? value) {
    data.email = value;
  }

  void onPasswordChanged(String? value) {
    data.password = value;
  }

  Future<void> login() async {
    try {
      startLoader();
      var response = await authRepository.login(data: data);
      stopLoader();
      if (response.isSuccessful) {
        emitEvent(const LoginEvent.success());
        return;
      }
      emitEvent(LoginEvent.failure(response.message));
    } catch (error) {
      stopLoader();
      emitEvent(const LoginEvent.failure());
    }
  }
}
