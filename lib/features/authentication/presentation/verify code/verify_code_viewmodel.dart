import 'package:reada/app%20core/base/base_vm.dart';
import 'package:reada/shared/constants.dart';

class VerifyCodeViewmodel extends BaseViewModel {
  void verifyCode() {
    Constants.navigationService.goBack<bool>(true);
  }
}
