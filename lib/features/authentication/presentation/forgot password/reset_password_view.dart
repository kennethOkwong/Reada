import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/app_strings/success_strings.dart';
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

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewmodel, ForgotPasswordEvent, void>(
      onModelReady: (vm) => vm.init(widget.email),
      onEvent: (context, vm, event) {
        switch (event.type) {
          case ForgotPasswordEventType.success:
            context.go(AppRoutes.login);
            HelperFunctions.showSuccessToast(
              SuccessStrings.passwordResetSuccess,
            );
            break;
          case ForgotPasswordEventType.failure:
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
                        children: [
                          PrimaryTextField(
                            title: AppStrings.password,
                            hintText: AppStrings.password,
                            isPassword: true,
                            obscureText: true,
                            onChanged: vm.onPasswordChanged,
                            validator: FormValidator.validatePassword,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: AppStrings.confirmPassword,
                            hintText: AppStrings.confirmPassword,
                            isPassword: true,
                            obscureText: true,
                            controller: _confirmPasswordController,
                            onChanged: vm.onCPasswordChanged,
                            validator: (value) {
                              return FormValidator.validateConfirmPassword(
                                vm.passwordResetModel.password,
                                value,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  title: AppStrings.resetPassword,
                  borderRadius: 24,
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      vm.resetPassword();
                    }
                  },
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
