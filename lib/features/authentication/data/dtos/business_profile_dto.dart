import 'package:reada/features/authentication/domain/entities/business_profile.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/helper_functions.dart';

class BusinessProfileDto {
  final int? businessProfileId;
  final String? businessName;
  final String? profileType;
  final String? description;
  final String? logo;
  final bool? isActive;
  final String? createdAt;

  BusinessProfileDto({
    this.businessProfileId,
    this.businessName,
    this.profileType,
    this.description,
    this.logo,
    this.isActive,
    this.createdAt,
  });

  /// JSON → DTO
  factory BusinessProfileDto.fromJson(Map<String, dynamic> json) {
    return BusinessProfileDto(
      businessProfileId: HelperFunctions.safeCast<int>(json['id']),
      businessName: HelperFunctions.safeCast<String>(json['business_name']),
      profileType: HelperFunctions.safeCast<String>(json['profile_type']),
      description: HelperFunctions.safeCast<String>(json['description']),
      logo: HelperFunctions.safeCast<String>(json['logo']),
      isActive: HelperFunctions.safeCast<bool>(json['is_active']),
      createdAt: HelperFunctions.safeCast<String>(json['created_at']),
    );
  }

  /// DTO → Domain
  BusinessProfile toDomain() {
    return BusinessProfile(
      businessProfileId: HelperFunctions.requireField(businessProfileId, 'id'),
      businessName: HelperFunctions.requireField(businessName, 'business_name'),
      profileType: HelperFunctions.requireField(profileType, 'profile_type'),
      description: description ?? Constants.defaultBusinessDesc,
      logo: logo ?? Constants.defaultBusinesslogo,
      isActive: isActive ?? false,
      createdAt: createdAt ?? Constants.defaultTimeStamp,
    );
  }

  /// JSON List → DTO List
  static List<BusinessProfileDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BusinessProfileDto.fromJson(json)).toList();
  }

  static List<BusinessProfile> toDomainList(List<BusinessProfileDto> list) {
    return list.map((value) => value.toDomain()).toList();
  }
}
