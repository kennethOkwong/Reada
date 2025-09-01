import 'package:reada/features/authentication/domain/entities/business_profile.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userType;
  final bool isVerified;
  final bool isActive;
  final String dateJoined;
  final String accessToken;
  final String refreshToken;
  final List<BusinessProfile> businessProfiles;
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userType,
    required this.isVerified,
    required this.isActive,
    required this.dateJoined,
    required this.accessToken,
    required this.refreshToken,
    required this.businessProfiles,
  });
}
