import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/stores/stores_event.dart';
import 'package:reada/features/stores/presentation/stores/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/helper_functions.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, List<String>>(
      // onModelReady: (model) => model.login(),
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case StoreEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case StoreEventType.success:
            //Handle unverified account
            if (!event.user!.isVerified) {
              final verified = await context.push<bool>(
                AppRoutes.enterCode,
                extra: vm.data.toSendCodeDto(),
              );
              if (verified != true) break;
            }

            //handle no business profile
            if (event.user!.businessProfiles.isEmpty) {
              context.mounted
                  ? context.push<bool>(AppRoutes.businessProfile)
                  : null;
              break;
            }
            context.mounted ? context.go(AppRoutes.dashboard) : null;
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Stores',
          ),
          drawer: SideDrawer(
            userName: "Kenneth Okwong",
            userEmail: "okwongkenneth36@gmail.com",
            onLogout: () {
              // Handle logout
            },
          ),
          body: Padding(
              padding: Constants.pagePadding(context),
              child: StateScreen(
                isLoading: vm.isLoading,
                hasError: vm.hasError,
                isEmpty: true,
                empty: EmptyState(
                  icon: Icons.history,
                  title: "No Data",
                  message:
                      "You don’t have any stores yet.\nStart by adding one!",
                  buttonText: "Add store",
                  onButtonPressed: () {
                    // handle action
                  },
                ),
                data: const Text('Stores list'),
              )),
        );
      },
    );
  }
}

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final IconData? icon;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 80,
                color: Colors.grey.shade400,
              ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

/// Reusable stateful screen wrapper
class StateScreen extends StatelessWidget {
  final Widget? data;
  final Widget? empty;
  final Widget? error;
  final bool isLoading;
  final bool hasError;
  final bool isEmpty;

  const StateScreen({
    super.key,
    required this.data,
    this.empty,
    this.error,
    this.isLoading = false,
    this.hasError = false,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return error ??
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                Text("Something went wrong",
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
    }

    if (isEmpty) {
      return empty ??
          const Center(
            child: Text("No data available"),
          );
    }

    return data ?? const SizedBox.shrink();
  }
}

class SideDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback? onLogout;

  const SideDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Home
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Stores'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Stores
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Settings
            },
          ),

          const Spacer(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
