import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/login_view/login_event.dart';
import 'package:reada/features/authentication/presentation/login_view/login_viewmodel.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewmodel, LoginEvent>(
      viewModel: LoginViewmodel(),
      onEvent: (context, model, event) {
        switch (event.type) {
          case LoginEventType.failure:
            HelperFunctions.showErrorToast(event.message);
            break;
          case LoginEventType.success:
            Constants.navigationService.navigateTo(AppRoutes.dashboard);
            break;
          default:
            break;
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
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
                    PrimaryTextField(
                      title: 'Email',
                      hintText: 'Email',
                      onChanged: model.onEmailChanged,
                      validator: FormValidator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    context.vSpacing24,
                    PrimaryTextField(
                      title: 'Password',
                      hintText: 'Password',
                      isPassword: true,
                      obscureText: true,
                      validator: (value) {
                        return FormValidator.validatePassword(value, true);
                      },
                      onChanged: model.onPasswordChanged,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Forgot password?'),
                          onPressed: () {
                            Constants.navigationService
                                .navigateTo(AppRoutes.enterEmail);
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
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                model.login();
                              }
                            },
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
                            Constants.navigationService
                                .navigateTo(AppRoutes.signUp);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
