class BusinessProfile {
  final int businessProfileId;
  final String businessName;
  final String profileType;
  final String description;
  final String logo;
  final bool isActive;
  final String createdAt;

  BusinessProfile({
    required this.businessProfileId,
    required this.businessName,
    required this.profileType,
    required this.description,
    required this.logo,
    required this.isActive,
    required this.createdAt,
  });
}
