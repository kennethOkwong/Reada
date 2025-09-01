import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/app_strings/app_strings.dart';
import 'package:reada/app/app_strings/error_strings.dart';
import 'package:reada/app/app_strings/success_strings.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_event.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_viewmodel.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/widgets/profile_type_selector.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/app%20images/images.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/profile_image_upload.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
// // phone field not validating alongside others, hence the need
// // for a separate key
// final _phoneFieldKey = GlobalKey<FormFieldState<PhoneNumber>>();

class BusinessProfileView extends StatelessWidget {
  const BusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BusinessProfileViewmodel, BusinessProfileEvent, void>(
      viewModel: BusinessProfileViewmodel(),
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case BusinessProfileEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case BusinessProfileEventType.navigateToDashborad:
            HelperFunctions.showSuccessToast(SuccessStrings.prifileCreated);
            context.go(AppRoutes.dashboard);
            break;
          case BusinessProfileEventType.navigateToLogin:
            HelperFunctions.showSuccessToast(SuccessStrings.prifileCreated);
            context.go(AppRoutes.login);
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.businessProfile,
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
                                    key: const ValueKey(0), vm: vm)
                                : _BusinessProfileForm2(
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
                      ? AppStrings.understood
                      : AppStrings.createProfile,
                  borderRadius: 24,
                  onPressed: () {
                    if (!_globalKey.currentState!.validate()) {
                      return;
                    }
                    if (vm.currentStep == 0) {
                      vm.goForward();
                      return;
                    }
                    vm.createBusinessProfile();
                  },
                ),
                context.vSpacing8,
                ReadaButton.outlined(
                  width: double.infinity,
                  title: AppStrings.back,
                  borderRadius: 24,
                  onPressed: () {
                    if (vm.currentStep == 1) return vm.goBackward();
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
          AppStrings.createBusinessProfile,
          style: context.textTheme.titleMedium,
        ),
        context.vSpacing16,
        Text(
          AppStrings.businessProfileDesc,
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        context.vSpacing32,
      ],
    );
  }
}

class _BusinessProfileForm2 extends StatefulWidget {
  const _BusinessProfileForm2({super.key, required this.vm});

  final BusinessProfileViewmodel vm;

  @override
  State<_BusinessProfileForm2> createState() => _BusinessProfileForm2State();
}

class _BusinessProfileForm2State extends State<_BusinessProfileForm2> {
  final businessNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final bioTextController = TextEditingController();

  @override
  void dispose() {
    businessNameTextController.dispose();
    emailTextController.dispose();
    phoneTextController.dispose();
    bioTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.vSpacing16,
        ImageUploadWidget(
          size: context.width * 0.3,
          onSelected: widget.vm.onProfileImageChanged,
        ),
        context.vSpacing32,
        ProfileTypeSelector(
          context: context,
          onChanged: widget.vm.onProfileTypeChanged,
          validator: (value) {
            if (value == null) {
              return ErrorStrings.selectProfileType;
            }
            return null;
          },
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.businessName,
          hintText: AppStrings.enterBusinessName,
          controller: businessNameTextController,
          onChanged: widget.vm.onbusinessNameChanged,
          validator: FormValidator.validateName,
        ),
        context.vSpacing16,
        // PrimaryTextField(
        //   title: AppStrings.businessEmail,
        //   hintText: AppStrings.enterBusinessEmail,
        //   controller: emailTextController,
        //   onChanged: widget.vm.onEmailChanged,
        //   validator: FormValidator.validateEmail,
        //   keyboardType: TextInputType.emailAddress,
        // ),
        // context.vSpacing16,
        // CustomPhoneNumberField(
        //   title: AppStrings.businessPhone,
        //   fieldKey: _phoneFieldKey,
        //   controller: phoneTextController,
        //   initialValue: widget.vm.data.businessPhone,
        //   onNumberChange: (phone) =>
        //       widget.vm.onPhoneChanged(phone?.completeNumber),
        // ),
        // context.vSpacing16,
        PrimaryTextField(
          title: AppStrings.bio,
          hintText: AppStrings.enterBio,
          controller: bioTextController,
          maxLines: 5,
          onChanged: widget.vm.onBioChanged,
        ),
        context.vSpacing32,
      ],
    );
  }
}
