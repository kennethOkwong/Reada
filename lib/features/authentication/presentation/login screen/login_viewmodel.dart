import 'package:reada/app/base/base_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';

class LoginViewmodel extends BaseViewModel {
  void navigateToSignUp() {
    Constants.navigationService.navigateTo(AppRoutes.signUp);
  }

  void navigateToForgotPassword() {
    Constants.navigationService.navigateTo(AppRoutes.enterEmail);
  }

  void login() {
    Constants.navigationService.navigateTo(AppRoutes.dashboard);
  }
}
