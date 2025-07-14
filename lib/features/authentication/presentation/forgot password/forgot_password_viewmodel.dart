import 'package:reada/app%20core/base/base_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/helper_functions.dart';

class ForgotPasswordViewmodel extends BaseViewModel {
  void navigateToVerifyCode() async {
    final verified =
        await Constants.navigationService.navigateTo(AppRoutes.enterCode);
    if (verified) {
      Constants.navigationService.navigateTo(AppRoutes.resetPassword);
    }
  }

  Future<void> resetPassword() async {
    Constants.navigationService.popUntilRoute(AppRoutes.login);
    HelperFunctions.showToast('Password reset successfull');
  }
}
