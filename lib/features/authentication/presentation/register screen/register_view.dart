import 'package:flutter/material.dart';
import 'package:reada/app%20core/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/register%20screen/register_viewmodel.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewmodel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  context.vSpacing24,
                  const PrimaryTextField(
                    title: 'First name',
                    hintText: 'First name',
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    title: 'Last name',
                    hintText: 'Last name',
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    title: 'Email',
                    hintText: 'Email',
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    title: 'Password',
                    hintText: 'Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  context.vSpacing24,
                  const PrimaryTextField(
                    hintText: 'Confirm password',
                    title: 'Confirm password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  context.vSpacing24,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Sign up',
                          borderRadius: 24,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      TextButton(
                        child: const Text('Login'),
                        onPressed: () {
                          model.navigateToLogin();
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
