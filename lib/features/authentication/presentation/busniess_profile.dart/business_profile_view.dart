import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/app/theme/theme.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_event.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_viewmodel.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/widgets/profile_type_selector.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/services/services.dart';
import 'package:reada/shared/app%20images/images.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/profile_image_upload.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/phone_field.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
//phone field not validating alongside others, hence the need
// for a seperate key
final _phoneFieldKey = GlobalKey<FormFieldState<PhoneNumber>>();

class BusinessProfileView extends StatelessWidget {
  const BusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BusinessProfileViewmodel, BusinessProfileEvent>(
      viewModel: BusinessProfileViewmodel(),
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case BusinessProfileEventType.failure:
            HelperFunctions.showErrorToast(event.message);
            break;
          case BusinessProfileEventType.success:
            final verified = await Services.navigationService.navigateTo(
                AppRoutes.enterCode,
                argument: vm.data.toSendCodeDto());
            if (verified == true) {
              HelperFunctions.showSuccessToast('Account created successfully');
              Services.navigationService.goBack();
            } else {
              HelperFunctions.showErrorToast('Failed to verify account');
              Services.navigationService.goBack();
            }
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Business profile',
            actions: [
              Padding(
                padding: Constants.pagePadding(context),
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
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: vm.currentStep == 0
                                ? _BusinessProfileForm1(
                                    key: const ValueKey(0),
                                    vm: vm,
                                  )
                                : _BusinessProfileForm2(
                                    key: const ValueKey(1),
                                    vm: vm,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: vm.currentStep == 0 ? 'Understood' : 'Create profile',
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
                  title: 'Back',
                  borderRadius: 24,
                  onPressed: () {
                    if (vm.currentStep == 1) return vm.goBackward();
                    Services.navigationService.goBack();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    ReadaButton.text(
                      title: 'Login',
                      onPressed: () {
                        if (readaAppThemeNotifier.isLight) {
                          readaAppThemeNotifier.darkMode();
                        } else {
                          readaAppThemeNotifier.lightMode();
                        }
                        // Services.navigationService.navigateTo(AppRoutes.login);
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

class _BusinessProfileForm1 extends StatelessWidget {
  const _BusinessProfileForm1({super.key, required this.vm});

  final BusinessProfileViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.vSpacing16,
        Container(
          margin: EdgeInsets.symmetric(vertical: context.spacing32),
          height: context.width * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(AppImages.bookStore),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          'Create a business profile',
          style: context.textTheme.titleMedium,
        ),
        context.vSpacing16,
        Text(
          '''A Business profile tells Reada how you’ll be using the app. Whether you’re an Author, a Bookstore, or an Affiliate — your profile helps us customize the tools and experience for your needs. You can create multiple profiles in one account, and switch between them at any time.''',
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        context.vSpacing32,
      ],
    );
  }
}

class _BusinessProfileForm2 extends StatelessWidget {
  const _BusinessProfileForm2({super.key, required this.vm});

  final BusinessProfileViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.vSpacing16,
        ImageUploadWidget(size: context.width * 0.3),
        context.vSpacing32,
        ProfileTypeSelector(
          context: context,
          onChanged: (value) {},
          validator: (value) {
            if (value == null) {
              return "Please select a profile type";
            }
            return null;
          },
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: 'Business name',
          hintText: 'Enter business name',
          controller: vm.fNameTextController,
          onChanged: vm.onFisrtNameChanged,
          validator: FormValidator.validateName,
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: 'Business email',
          hintText: 'Enter business email',
          controller: vm.emailTextController,
          onChanged: vm.onEmailChanged,
          validator: FormValidator.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        context.vSpacing16,
        CustomPhoneNumberField(
          title: 'Business phone number',
          fieldKey: _phoneFieldKey,
          controller: vm.phoneTextController,
          initialValue: vm.data.phone,
          onNumberChange: (phone) => vm.onPhoneChanged(phone?.completeNumber),
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: 'Bio',
          hintText: 'Enter a short bio',
          controller: vm.lNameTextController,
          maxLines: 5,
          onChanged: vm.onLastNameChanged,
          validator: FormValidator.validateName,
        ),
        context.vSpacing32,
      ],
    );
  }
}
