import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_event.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/pin_input_field.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key, required this.codeModel});

  final SendCodeDataModel codeModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyCodeViewmodel, VerifyCodeEvent>(
      onModelReady: (model) => model.init(codeModel),
      onEvent: (context, model, event) {
        switch (event) {
          case VerifyCodeEvent.success:
            Constants.navigationService.goBack<bool>(true);
            break;
          case VerifyCodeEvent.failure:
            HelperFunctions.showErrorToast(event.message);
            break;
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // context.vSpacing32,
                  Text(
                    'Enter verification code sent to\n${codeModel.email}',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  context.vSpacing20,
                  PinInputField(
                    onCompleted: model.onCompleted,
                  ),
                  context.vSpacing32,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Submit',
                          borderRadius: 24,
                          onPressed: () {
                            model.verifyCode();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Did not receive code? 0:23'),
                      TextButton(
                        child: const Text('Resend '),
                        onPressed: () {
                          // model.navigateToSignUp();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
