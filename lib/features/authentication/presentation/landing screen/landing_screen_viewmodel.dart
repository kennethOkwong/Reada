import 'package:reada/app%20core/base/base_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';

class LandingScreenViewmodel extends BaseViewModel {
  void navigateToLogin() {
    Constants.navigationService.navigateTo(AppRoutes.login);
  }

  void navigateToSignUp() {
    Constants.navigationService.navigateTo(AppRoutes.signUp);
  }
}
