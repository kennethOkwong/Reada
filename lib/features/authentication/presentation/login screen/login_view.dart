import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/login%20screen/login_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewmodel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Hello Again!',
                    style: context.textTheme.titleLarge,
                  ),
                  context.vSpacing20,
                  Text(
                    'Nice having you again',
                    style: context.textTheme.bodyMedium,
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    hintText: 'Email',
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Forgot password?'),
                        onPressed: () {
                          model.navigateToForgotPassword();
                        },
                      ),
                    ],
                  ),
                  context.vSpacing24,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Login',
                          borderRadius: 24,
                          onPressed: model.login,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      TextButton(
                        child: const Text('Sign up'),
                        onPressed: () {
                          model.navigateToSignUp();
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
