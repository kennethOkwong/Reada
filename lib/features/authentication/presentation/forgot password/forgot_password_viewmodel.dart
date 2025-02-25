import 'package:reada/app%20core/base/base_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';

class ForgotPasswordViewmodel extends BaseViewModel {
  void navigateToEnterCode() {
    Constants.navigationService.navigateTo(AppRoutes.enterCode);
  }

  void navigateToResetPassword() {
    Constants.navigationService.navigateTo(AppRoutes.resetPassword);
  }
}
