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

class EnterEmailView extends StatelessWidget {
  EnterEmailView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewmodel, ForgotPasswordEvent>(
      onEvent: (context, model, event) async {
        switch (event.type) {
          case ForgotPasswordEventType.failure:
            HelperFunctions.showErrorToast(event.message);
            break;
          case ForgotPasswordEventType.navigateToVery:
            final verified = await Constants.navigationService
                .navigateTo(AppRoutes.enterCode, argument: event.data);
            if (verified) {
              Constants.navigationService.navigateTo(AppRoutes.resetPassword,
                  argument: event.data.email);
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your registered email',
                      style: context.textTheme.bodyMedium,
                    ),
                    context.vSpacing16,
                    PrimaryTextField(
                      title: 'Email',
                      hintText: 'Email',
                      onChanged: model.onEmailChanged,
                      validator: FormValidator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    context.vSpacing32,
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: 'Continue',
                            borderRadius: 24,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                model.sendCode();
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
