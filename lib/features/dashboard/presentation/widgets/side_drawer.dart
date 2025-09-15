import 'package:flutter/material.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class SideDrawer extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const SideDrawer({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          // bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '${user.firstName} ${user.lastName}',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user.email,
              style: context.textTheme.labelLarge
                  ?.copyWith(color: context.colorScheme.onPrimary),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '${user.firstName.isNotEmpty ? user.firstName[0] : 'P'}${user.lastName.isNotEmpty ? user.lastName[0] : ''}',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BusinessProfileList(
            profiles: [
              BusinessProfile(
                businessName: "Cadenny Enterprise intl ltd",
                businessType: "Profile type: Author",
              ),
              BusinessProfile(
                businessName: "Tech Corp",
                businessType: "IT Services for all enginners",
              ),
            ],
            selectedProfile: BusinessProfile(
              businessName: "Tech Corp",
              businessType: "IT Services for all enginners",
            ),
            onProfileSelected: (profile) {
              // Handle switching profile
              debugPrint("Switched to ${profile.businessName}");
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: context.colorScheme.error),
            title: Text('Logout',
                style: context.textTheme.titleMedium
                    ?.copyWith(color: context.colorScheme.error)),
            onTap: onLogout,
          ),
          context.vSpacing16,
        ],
      ),
    );
  }
}

class BusinessProfile {
  final String businessName;
  final String businessType;
  final String? profileImage;

  BusinessProfile({
    required this.businessName,
    required this.businessType,
    this.profileImage,
  });
}

class BusinessProfileList extends StatelessWidget {
  final List<BusinessProfile> profiles;
  final BusinessProfile? selectedProfile;
  final ValueChanged<BusinessProfile> onProfileSelected;

  const BusinessProfileList({
    super.key,
    required this.profiles,
    required this.onProfileSelected,
    this.selectedProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // makes the list take remaining drawer height
      child: ListView.separated(
        itemCount: profiles.length,
        separatorBuilder: (context, index) => context.vSpacing16,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final isSelected =
              profile.businessName == selectedProfile?.businessName;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.surfaceContainerHighest
                  : null,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isSelected
                      ? context.colorScheme.inversePrimary
                      : context.colorScheme.surfaceContainerHigh),
            ),
            child: ListTile(
              leading: profile.profileImage != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(profile.profileImage!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        profile.businessName.isNotEmpty
                            ? profile.businessName[0].toUpperCase()
                            : "?",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
              title: Text(
                profile.businessName,
                style: context.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                profile.businessType,
                style: context.textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: context.colorScheme.inversePrimary,
                    )
                  : null,
              onTap: () => onProfileSelected(profile),
            ),
          );
        },
      ),
    );
  }
}
