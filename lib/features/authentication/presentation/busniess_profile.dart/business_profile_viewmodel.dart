import 'dart:io';

import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/authentication/data/dtos/create_business_profile_requestdto.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/features/authentication/presentation/busniess_profile.dart/business_profile_event.dart';
import 'package:reada/shared/enums/profile_type_enum.dart';

class BusinessProfileViewmodel
    extends BaseViewModel<BusinessProfileEvent, void> {
  CreateBusinessProfileRequestDto data =
      CreateBusinessProfileRequestDto.empty();
  int currentStep = 0;
  bool isForward = true;

  void goForward() {
    isForward = true;
    currentStep = 1;
    notifyListeners();
  }

  void goBackward() {
    isForward = false;
    currentStep = 0;
    notifyListeners();
  }

  void onProfileImageChanged(File? value) {
    data = data.copyWith(profileImage: value);
  }

  void onProfileTypeChanged(ProfileType? value) {
    data = data.copyWith(profileType: value);
  }

  void onbusinessNameChanged(String? value) {
    data = data.copyWith(businessName: value);
  }

  void onEmailChanged(String? value) {
    data = data.copyWith(businessEmail: value);
  }

  void onPhoneChanged(String? value) {
    data = data.copyWith(businessPhone: value);
  }

  void onBioChanged(String? value) {
    data = data.copyWith(bio: value);
  }

  Future<void> createBusinessProfile() async {
    setLoading();
    var result = await createBusinessProfileUsecase.call(data);
    setIdle();
    result.when(
      success: (data, message) {
        if (data == null) {
          emitEvent(const BusinessProfileEvent.navigateToLogin());
          return;
        }
        emitEvent(const BusinessProfileEvent.navigateToDashborad());
      },
      failure: (exception) {
        emitEvent(BusinessProfileEvent.failure(exception.toString()));
      },
    );
  }
}
