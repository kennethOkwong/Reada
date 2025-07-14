import 'package:flutter/material.dart';
import 'package:reada/app%20core/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

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
                children: [
                  const PrimaryTextField(
                    hintText: 'Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    hintText: 'Confirm password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  context.vSpacing24,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Reset password',
                          borderRadius: 24,
                          onPressed: () {
                            model.resetPassword();
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
