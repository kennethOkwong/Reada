import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/enums/user_type_enum.dart';
import 'package:reada/shared/helper_functions.dart';

class LoginResponseDto {
  final String? userId;
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

  LoginResponseDto({
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
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>? ?? {};

    return LoginResponseDto(
      userId: userJson['id'] as String?,
      email: userJson['email'] as String?,
      firstName: userJson['first_name'] as String?,
      lastName: userJson['last_name'] as String?,
      phoneNumber: userJson['phone_number'] as String?,
      userType: userJson['user_type'] as String?,
      isVerified: userJson['is_verified'] as bool?,
      isActive: userJson['is_active'] as bool?,
      dateJoined: userJson['date_joined'] as String?,
      accessToken: json['access'] as String?,
      refreshToken: json['refresh'] as String?,
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
    );
  }
}
