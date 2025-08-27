import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_event.dart';
import 'package:reada/shared/constants.dart';

class VerifyCodeViewmodel extends BaseViewModel<VerifyCodeEvent> {
  Timer? _timer;
  int time = 60;
  VerifyCodeRequestDto _data = VerifyCodeRequestDto.empty();

  String get timeLeft {
    final dt = DateTime(0, 0, 0, 0, time ~/ 60, time % 60);
    return DateFormat('m:ss').format(dt);
  }

  void startTimer() {
    time = 60;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time == 0) {
          _timer?.cancel();
          return;
        }
        time--;
        notifyListeners();
      },
    );
  }

  void onCompleted(String code) {
    _data = _data.copyWith(code: code);
  }

  void init(SendCodeRequestDto codeModel) {
    _data = _data.copyWith(
      email: codeModel.email,
      codeType: codeModel.codeType,
    );
    startTimer();
  }

  Future<void> verifyCode() async {
    startLoader();
    var result = await verifyCodeUseCase.call(_data);
    stopLoader();
    result.when(
      success: (data) {
        log(data.toString());
        emitEvent(const VerifyCodeEvent.verifySuccess());
      },
      failure: (message) {
        log(message.toString());
        emitEvent(VerifyCodeEvent.verifyFailure(message));
      },
    );
  }

  Future<void> resendCode(SendCodeRequestDto codeModel) async {
    startLoader();
    final result = await sendCodeUseCase.call(codeModel);
    stopLoader();
    result.when(
      success: (data) {
        emitEvent(const VerifyCodeEvent.resendSuccess());
      },
      failure: (message) {
        emitEvent(VerifyCodeEvent.resendFailure(Constants.genericError));
      },
    );
  }
}
