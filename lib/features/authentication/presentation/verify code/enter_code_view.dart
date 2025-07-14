import 'package:flutter/material.dart';
import 'package:reada/app%20core/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/verify%20code/verify_code_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/pin_input_field.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyCodeViewmodel>(
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
                    'Enter verification code sent to\nokwongkenneth36@gmail.com',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  context.vSpacing20,
                  PinInputField(
                    onCompleted: (pin) {},
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
