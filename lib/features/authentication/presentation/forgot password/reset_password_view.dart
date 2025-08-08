import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_event.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key, required this.email});

  final String email;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewmodel, ForgotPasswordEvent>(
      onEvent: (context, model, event) {
        switch (event) {
          case ForgotPasswordEvent.success:
            Constants.navigationService.popUntilRoute(AppRoutes.login);
            HelperFunctions.showSuccessToast('Password reset successfull');
            break;
          case ForgotPasswordEvent.failure:
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
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    PrimaryTextField(
                      title: 'Password',
                      hintText: 'Password',
                      isPassword: true,
                      obscureText: true,
                      onChanged: model.onPasswordChanged,
                      validator: FormValidator.validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    context.vSpacing16,
                    PrimaryTextField(
                        hintText: 'Confirm password',
                        title: 'Confirm password',
                        isPassword: true,
                        obscureText: true,
                        validator: (value) {
                          return FormValidator.validateConfirmPassword(
                            model.passwordResetModel.password,
                            value,
                          );
                        }),
                    context.vSpacing24,
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: 'Reset password',
                            borderRadius: 24,
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                model.resetPassword(email);
                              }
                            },
                          ),
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
