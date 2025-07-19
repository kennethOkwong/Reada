import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class EnterEmailView extends StatelessWidget {
  const EnterEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewmodel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter your registered email',
                    style: context.textTheme.bodyMedium,
                  ),
                  context.vSpacing16,
                  const PrimaryTextField(
                    hintText: 'Email',
                  ),
                  context.vSpacing32,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Continue',
                          borderRadius: 24,
                          onPressed: () {
                            model.navigateToVerifyCode();
                          },
                        ),
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
