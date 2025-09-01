import 'dart:io';

import 'package:reada/shared/enums/profile_type_enum.dart';

class CreateBusinessProfileRequestDto {
  final File? profileImage;
  final ProfileType? profileType;
  final String? businessName;
  final String? businessEmail;
  final String? businessPhone;
  final String? bio;

  CreateBusinessProfileRequestDto({
    required this.profileImage,
    required this.profileType,
    required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
    required this.bio,
  });

  factory CreateBusinessProfileRequestDto.empty() {
    return CreateBusinessProfileRequestDto(
      profileImage: null,
      profileType: null,
      businessName: null,
      businessEmail: null,
      businessPhone: null,
      bio: null,
    );
  }

  CreateBusinessProfileRequestDto copyWith({
    File? profileImage,
    ProfileType? profileType,
    String? businessName,
    String? businessEmail,
    String? businessPhone,
    String? bio,
  }) {
    return CreateBusinessProfileRequestDto(
      businessName: businessName ?? this.businessName,
      profileType: profileType ?? this.profileType,
      businessEmail: businessEmail ?? this.businessEmail,
      businessPhone: businessPhone ?? this.businessPhone,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "logo": profileImage,
      "business_name": businessName,
      "profile_type": profileType?.value,
      // "businessEmail": businessEmail,
      // "businessPhone_number": businessPhone,
      "bio": bio,
    };
  }
}
