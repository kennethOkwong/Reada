import 'package:reada/app%20core/base/base_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/helper_functions.dart';

class RegisterViewmodel extends BaseViewModel {
  void navigateToLogin() {
    Constants.navigationService.navigateTo(AppRoutes.login);
  }

  void navigateToVerifyCode() async {
    final verified =
        await Constants.navigationService.navigateTo(AppRoutes.enterCode);
    if (verified) {
      HelperFunctions.showToast('Account created successfully');
      Constants.navigationService.goBack();
    }
  }
}
