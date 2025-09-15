import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/app_strings/error_strings.dart';
import 'package:reada/app/app_strings/success_strings.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/register_view/register_event.dart';
import 'package:reada/features/authentication/presentation/register_view/register_viewmodel.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/phone_field.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
final _phoneFieldKey = GlobalKey<FormFieldState<PhoneNumber>>();

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewmodel, RegisterEvent, void>(
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case RegisterEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case RegisterEventType.success:
            final verified = await context.push<bool>(
              AppRoutes.enterCode,
              extra: vm.data.toSendCodeDto(),
            );
            //handle verified case
            if (verified == true) {
              HelperFunctions.showSuccessToast(SuccessStrings.accountCreated);
              context.mounted
                  ? context.pushReplacement(AppRoutes.businessProfile)
                  : null;
              break;
            }
            //Handle not verified case
            HelperFunctions.showErrorToast(ErrorStrings.verificationFailed);
            context.mounted ? context.pop() : null;
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.register,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text('${vm.currentStep + 1}/2'),
              )
            ],
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _globalKey,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                            child: vm.currentStep == 0
                                ? _RegisterForm1(key: const ValueKey(0), vm: vm)
                                : _RegisterForm2(
                                    key: const ValueKey(1), vm: vm),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: vm.currentStep == 0
                      ? AppStrings.next
                      : AppStrings.register,
                  borderRadius: 24,
                  onPressed: () {
                    if (!_globalKey.currentState!.validate() &&
                        !_phoneFieldKey.currentState!.validate()) {
                      return;
                    }
                    if (vm.currentStep == 0) {
                      vm.goForward();
                      return;
                    }
                    vm.register();
                  },
                ),
                context.vSpacing8,
                ReadaButton.outlined(
                  width: double.infinity,
                  title: AppStrings.back,
                  borderRadius: 24,
                  onPressed: () {
                    if (vm.currentStep == 1) vm.goBackward();
                    context.pop();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.alreadyMember),
                    ReadaButton.text(
                      title: AppStrings.login,
                      onPressed: () {
                        context.push(AppRoutes.login);
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

class _RegisterForm1 extends StatefulWidget {
  const _RegisterForm1({super.key, required this.vm});
  final RegisterViewmodel vm;

  @override
  State<_RegisterForm1> createState() => _RegisterForm1State();
}

class _RegisterForm1State extends State<_RegisterForm1> {
  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  @override
  void dispose() {
    fNameTextController.dispose();
    lNameTextController.dispose();
    phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.firstName,
          hintText: AppStrings.firstName,
          controller: fNameTextController,
          onChanged: widget.vm.onFisrtNameChanged,
          validator: FormValidator.validateName,
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.lastName,
          hintText: AppStrings.lastName,
          controller: lNameTextController,
          onChanged: widget.vm.onLastNameChanged,
          validator: FormValidator.validateName,
        ),
        context.vSpacing16,
        CustomPhoneNumberField(
          title: AppStrings.phoneNumber,
          fieldKey: _phoneFieldKey,
          controller: phoneTextController,
          initialValue: widget.vm.data.phone,
          onNumberChange: (phone) =>
              widget.vm.onPhoneChanged(phone?.completeNumber),
        ),
        context.vSpacing32,
      ],
    );
  }
}

class _RegisterForm2 extends StatefulWidget {
  const _RegisterForm2({super.key, required this.vm});
  final RegisterViewmodel vm;

  @override
  State<_RegisterForm2> createState() => _RegisterForm2State();
}

class _RegisterForm2State extends State<_RegisterForm2> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final cPasswordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    cPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.email,
          hintText: AppStrings.email,
          controller: emailTextController,
          onChanged: widget.vm.onEmailChanged,
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
          onChanged: widget.vm.onPasswordChanged,
          validator: FormValidator.validatePassword,
          keyboardType: TextInputType.visiblePassword,
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.confirmPassword,
          hintText: AppStrings.confirmPassword,
          isPassword: true,
          obscureText: true,
          controller: cPasswordTextController,
          onChanged: widget.vm.onConfirmPasswordChanged,
          validator: (value) {
            return FormValidator.validateConfirmPassword(
              widget.vm.data.password,
              value,
            );
          },
        ),
        context.vSpacing32,
      ],
    );
  }
}
