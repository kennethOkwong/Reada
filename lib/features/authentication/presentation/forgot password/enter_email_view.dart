import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_event.dart';
import 'package:reada/features/authentication/presentation/forgot%20password/forgot_password_viewmodel.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class EnterEmailView extends StatefulWidget {
  const EnterEmailView({super.key});

  @override
  State<EnterEmailView> createState() => _EnterEmailViewState();
}

class _EnterEmailViewState extends State<EnterEmailView> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewmodel, ForgotPasswordEvent, void>(
      onEvent: (context, model, event) async {
        switch (event.type) {
          case ForgotPasswordEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case ForgotPasswordEventType.navigateToVery:
            final verified =
                await context.push(AppRoutes.enterCode, extra: event.data);
            if (verified == true && context.mounted) {
              context.push(
                AppRoutes.resetPassword,
                extra: event.data.email,
              );
            }
            break;
          default:
            break;
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: AppStrings.forgotPassword,
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.enterEmail,
                            style: context.textTheme.bodyMedium,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: AppStrings.email,
                            hintText: AppStrings.email,
                            onChanged: model.onEmailChanged,
                            controller: emailTextController,
                            validator: FormValidator.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: AppStrings.continueString,
                  borderRadius: 24,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      model.sendCode();
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
