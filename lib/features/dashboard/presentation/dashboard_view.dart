import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/dashboard/domain/models/bottom_nav_model.dart';
import 'package:reada/features/dashboard/presentation/dashboard_event.dart';
import 'package:reada/features/dashboard/presentation/dashboard_viewmodel.dart';
import 'package:reada/features/dashboard/presentation/widgets/side_drawer.dart';
import 'package:reada/features/inventory/presentation/inventory_list/invenory_list_view.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_view.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/app%20images/svg_icons.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/state_screen.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewmodel, DashboardEvent, void>(
      builder: (context, model, child) {
        return PopScope(
          canPop: model.currentIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (model.currentIndex != 0) {
              model.updateCurrenctIndex(0);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  appBar: CustomAppBar(
                    title: model.appBarTitle,
                    centerTitle: false,
                    titleStyle: context.textTheme.titleLarge,
                  ),
                  drawer: SideDrawer(
                    user: User(
                        id: 1,
                        email: 'okwongkenneth36@gmail.com',
                        firstName: 'Kenneth',
                        lastName: 'Okwong',
                        phoneNumber: '',
                        userType: '',
                        isVerified: true,
                        isActive: true,
                        dateJoined: '',
                        accessToken: '',
                        refreshToken: '',
                        businessProfiles: []),
                    onLogout: () {
                      // Handle logout
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // readaAppThemeNotifier.darkMode();
                      context.push(AppRoutes.addStore);
                    },
                    child: const Icon(Icons.add),
                  ),
                  body: Padding(
                    padding: Constants.pagePadding(context),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: IndexedStack(
                            index: model.currentIndex,
                            children: [
                              StateScreen(
                                isLoading: model.isLoading,
                                hasError: model.hasError,
                                isEmpty: true,
                                empty: EmptyState(
                                  title: "No Data",
                                  message:
                                      "You don’t have any orders yet.\nStart by creating a local order!",
                                  buttonText: "Create local order",
                                  onButtonPressed: () {
                                    // handle action
                                  },
                                ),
                                data: const Text('Order list'),
                              ),
                              const InventoryListView(),
                              const StoresView(),
                            ],
                          ),
                        ),

                        // Bottom Nav Bar
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                color: context.colorScheme.secondaryContainer,
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    children: dashboardTabs.mapIndexed((i, val) {
                      return Expanded(
                        child: _buildNavBarItem(
                          context: context,
                          isSelected: model.currentIndex == i,
                          text: val.name,
                          icon: val.icon,
                          onPressed: () => model.updateCurrenctIndex(i),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavBarItem({
    required BuildContext context,
    required String text,
    required String icon,
    required bool isSelected,
    required void Function()? onPressed,
  }) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              name: icon,
              size: 20,
              iconColor: isSelected
                  ? context.colorScheme.secondary
                  : context.colorScheme.onSecondaryContainer,
            ),
            context.vSpacing4,
            Text(text,
                style: context.textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? context.colorScheme.secondary
                      : context.colorScheme.onSecondaryContainer,
                )),
            // const AppSpacing.v8(),
          ],
        ),
      ),
    );
  }
}
