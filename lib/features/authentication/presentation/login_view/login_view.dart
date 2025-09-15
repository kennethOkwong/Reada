import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/app_strings/app_strings.dart';
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

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewmodel, LoginEvent, void>(
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case LoginEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case LoginEventType.success:
            //Handle unverified account
            if (!event.user!.isVerified) {
              final verified = await context.push<bool>(
                AppRoutes.enterCode,
                extra: vm.data.toSendCodeDto(),
              );
              if (verified != true) break;
            }

            //handle no business profile
            if (event.user!.businessProfiles.isEmpty) {
              context.mounted
                  ? context.push<bool>(AppRoutes.businessProfile)
                  : null;
              break;
            }
            context.mounted ? context.go(AppRoutes.dashboard) : null;
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
                      key: _globalKey,
                      child: Column(
                        children: [
                          Text(
                            AppStrings.helloAgain,
                            style: context.textTheme.titleLarge,
                          ),
                          context.vSpacing20,
                          Text(
                            AppStrings.welcomeBack,
                            style: context.textTheme.bodyMedium,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: AppStrings.email,
                            hintText: AppStrings.email,
                            controller: emailTextController,
                            onChanged: vm.onEmailChanged,
                            validator: FormValidator.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: AppStrings.password,
                            hintText: AppStrings.password,
                            isPassword: true,
                            obscureText: true,
                            controller: passwordTextController,
                            onChanged: vm.onPasswordChanged,
                            validator: (value) =>
                                FormValidator.validatePassword(value, true),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: AppStrings.login,
                  borderRadius: 24,
                  onPressed: () {
                    if (!_globalKey.currentState!.validate()) {
                      return;
                    }

                    vm.login();
                  },
                ),
                context.vSpacing8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.notAMember),
                    ReadaButton.text(
                      title: AppStrings.register,
                      onPressed: () {
                        context.push(AppRoutes.register);
                      },
                    ),
                  ],
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
