import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/app_strings/success_strings.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_event.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/pin_input_field.dart';

class EnterCodeView extends StatefulWidget {
  const EnterCodeView({super.key, required this.codeModel});

  final SendCodeRequestDto codeModel;

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();
}

class _EnterCodeViewState extends State<EnterCodeView> {
  final _key = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyCodeViewmodel, VerifyCodeEvent, void>(
      onModelReady: (vm) => vm.init(widget.codeModel),
      onEvent: (context, vm, event) {
        switch (event.type) {
          case VerifyCodeEventType.verifySuccess:
            context.pop(true);
            break;
          case VerifyCodeEventType.verifyFailure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case VerifyCodeEventType.resendSuccess:
            HelperFunctions.showErrorToast(SuccessStrings.codeResent);
            vm.startTimer();
            break;
          case VerifyCodeEventType.resendFailure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: AppStrings.enterVerification,
                              style: context.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: widget.codeModel.email,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          context.vSpacing20,
                          PinInputField(
                            onCompleted: vm.onCompleted,
                            validator: FormValidator.validateCode,
                            controller: _codeController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: AppStrings.submit,
                  borderRadius: 24,
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      vm.verifyCode();
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: AppStrings.didNotReceive,
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: vm.timeLeft,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReadaButton.text(
                      enabled: vm.time == 0,
                      title: AppStrings.resend,
                      onPressed: () {
                        vm.resendCode(widget.codeModel);
                      },
                    ),
                  ],
                ),
                context.vSpacing32,
              ],
            ),
          ),
        );
      },
    );
  }
}
