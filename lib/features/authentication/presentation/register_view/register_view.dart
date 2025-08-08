import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/register_view/register_event.dart';
import 'package:reada/features/authentication/presentation/register_view/register_viewmodel.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/phone_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  //phone field not validating alongside others, hence the need
  // for a seperate key
  final _phoneFieldKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewmodel, RegisterEvent>(
      onEvent: (context, model, event) async {
        switch (event.type) {
          case RegisterEventType.failure:
            HelperFunctions.showErrorToast(event.message);
            break;
          case RegisterEventType.success:
            model.sendCode();
            final verified = await Constants.navigationService
                .navigateTo(AppRoutes.enterCode, argument: model.codeModel);
            if (verified) {
              HelperFunctions.showSuccessToast('Account created successfully');
              Constants.navigationService.navigateTo(AppRoutes.login);
            } else {
              Constants.navigationService.goBack();
              HelperFunctions.showErrorToast('Failed to verify account');
            }
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
                key: _globalKey,
                child: Column(
                  children: [
                    context.vSpacing16,
                    PrimaryTextField(
                      title: 'First name',
                      hintText: 'First name',
                      onChanged: model.onFisrtNameChanged,
                      validator: FormValidator.validateName,
                    ),
                    context.vSpacing16,
                    PrimaryTextField(
                      title: 'Last name',
                      hintText: 'Last name',
                      onChanged: model.onLastNameChanged,
                      validator: FormValidator.validateName,
                    ),
                    context.vSpacing16,
                    PrimaryTextField(
                      title: 'Email',
                      hintText: 'Email',
                      onChanged: model.onEmailChanged,
                      validator: FormValidator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    context.vSpacing16,
                    CustomPhoneNumberField(
                      title: 'Phone number',
                      fieldKey: _phoneFieldKey,
                      onNumberChange: (phone) =>
                          model.onPhoneChanged(phone?.completeNumber),
                    ),
                    context.vSpacing16,
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
                        onChanged: model.onConfirmPasswordChanged,
                        validator: (value) {
                          log('${model.data.password} $value');
                          return FormValidator.validateConfirmPassword(
                            model.data.password,
                            value,
                          );
                        }),
                    context.vSpacing24,
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: 'Sign up',
                            borderRadius: 24,
                            onPressed: () {
                              if (_globalKey.currentState!.validate() &&
                                  _phoneFieldKey.currentState!.validate()) {
                                model.register();
                              }
                            },
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
                            Constants.navigationService
                                .navigateTo(AppRoutes.login);
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
