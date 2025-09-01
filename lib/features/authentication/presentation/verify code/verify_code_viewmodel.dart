import 'dart:async';

import 'package:intl/intl.dart';
import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_event.dart';

class VerifyCodeViewmodel extends BaseViewModel<VerifyCodeEvent, void> {
  Timer? _timer;
  int time = 30;
  VerifyCodeRequestDto _data = VerifyCodeRequestDto.empty();

  String get timeLeft {
    final dt = DateTime(0, 0, 0, 0, time ~/ 60, time % 60);
    return DateFormat('m:ss').format(dt);
  }

  void startTimer() {
    time = 30;
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

  void resetTimer() {
    _timer?.cancel();
    time = 0;
    notifyListeners();
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
    setLoading();
    var result = await verifyCodeUseCase.call(_data);
    setIdle();
    result.when(
      success: (data, message) {
        emitEvent(const VerifyCodeEvent.verifySuccess());
      },
      failure: (exception) {
        emitEvent(VerifyCodeEvent.verifyFailure(exception.toString()));
      },
    );
  }

  Future<void> resendCode(SendCodeRequestDto codeModel) async {
    setLoading();
    final result = await sendCodeUseCase.call(codeModel);
    setIdle();
    result.when(
      success: (data, message) {
        emitEvent(const VerifyCodeEvent.resendSuccess());
      },
      failure: (exception) {
        emitEvent(VerifyCodeEvent.resendFailure(exception.toString()));
      },
    );
  }
}
