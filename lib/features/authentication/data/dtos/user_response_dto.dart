import 'package:reada/features/authentication/data/dtos/business_profile_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/enums/user_type_enum.dart';
import 'package:reada/shared/helper_functions.dart';

class UserDto {
  final int? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? userType;
  final bool? isVerified;
  final bool? isActive;
  final String? dateJoined;
  final String? accessToken;
  final String? refreshToken;
  final List<BusinessProfileDto> businessProfiles;

  UserDto({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.userType,
    this.isVerified,
    this.isActive,
    this.dateJoined,
    this.accessToken,
    this.refreshToken,
    this.businessProfiles = const [],
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>? ?? {};

    return UserDto(
      userId: HelperFunctions.safeCast<int>(userJson['id']),
      email: HelperFunctions.safeCast<String>(userJson['email']),
      firstName: HelperFunctions.safeCast<String>(userJson['first_name']),
      lastName: HelperFunctions.safeCast<String>(userJson['last_name']),
      phoneNumber: HelperFunctions.safeCast<String>(userJson['phone_number']),
      userType: HelperFunctions.safeCast<String>(userJson['user_type']),
      isVerified: HelperFunctions.safeCast<bool>(userJson['is_verified']),
      isActive: HelperFunctions.safeCast<bool>(userJson['is_active']),
      dateJoined: HelperFunctions.safeCast<String>(userJson['date_joined']),
      businessProfiles:
          BusinessProfileDto.fromJsonList(userJson['business_profiles'] ?? []),
      accessToken: HelperFunctions.safeCast<String>(json['access']),
      refreshToken: HelperFunctions.safeCast<String>(json['refresh']),
    );
  }

  User toDomain() {
    return User(
      id: HelperFunctions.requireField(userId, 'id'),
      email: HelperFunctions.requireField(email, 'email'),
      firstName: HelperFunctions.requireField(firstName, 'first_name'),
      lastName: HelperFunctions.requireField(lastName, 'last_name'),
      phoneNumber: phoneNumber ?? Constants.defaultPhone,
      userType: userType ?? UserType.vendor.name,
      isVerified: HelperFunctions.requireField(isVerified, 'is_verified'),
      isActive: HelperFunctions.requireField(isActive, 'is_active'),
      dateJoined: dateJoined ?? Constants.defaultTimeStamp,
      accessToken: HelperFunctions.requireField(accessToken, 'access'),
      refreshToken: HelperFunctions.requireField(refreshToken, 'refresh'),
      businessProfiles: HelperFunctions.requireField(
        BusinessProfileDto.toDomainList(businessProfiles),
        'business_profiles',
      ),
    );
  }

  /// Domain Entity → DTO
  factory UserDto.fromDomain(User user) {
    return UserDto(
      userId: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      userType: user.userType,
      isVerified: user.isVerified,
      isActive: user.isActive,
      dateJoined: user.dateJoined,
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
    );
  }

  /// DTO → JSON (for storage or API calls)
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': userId,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'user_type': userType,
        'is_verified': isVerified,
        'is_active': isActive,
        'date_joined': dateJoined,
      },
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
