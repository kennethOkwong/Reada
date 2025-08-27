class User {
  final String id;
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
  });
}
