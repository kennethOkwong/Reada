import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/entities/verify_code_data_model.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_event.dart';

class VerifyCodeViewmodel extends BaseViewModel<VerifyCodeEvent> {
  final data = VerifyCodeDataModel();

  void onCompleted(String code) {
    data.code = code;
  }

  void init(SendCodeDataModel codeModel) {
    data
      ..email = codeModel.email
      ..codeType = codeModel.codeType;
  }

  Future<void> verifyCode() async {
    try {
      startLoader();
      var response = await authRepository.verifyOTP(data: data);
      stopLoader();
      if (response.isSuccessful) {
        emitEvent(const VerifyCodeEvent.success());
        return;
      }
      emitEvent(VerifyCodeEvent.failure(response.message));
    } catch (error) {
      stopLoader();
      emitEvent(const VerifyCodeEvent.failure());
    }
  }
}
