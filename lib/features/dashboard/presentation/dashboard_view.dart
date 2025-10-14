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
import 'package:reada/features/order/presentation/order_list/order_list_view.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_view.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/app%20images/svg_icons.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewmodel, DashboardEvent, void>(
      builder: (context, vm, child) {
        return PopScope(
          canPop: vm.currentIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (vm.currentIndex != 0) {
              vm.updateCurrenctIndex(0);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  appBar: CustomAppBar(
                    title: vm.appBarTitle,
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
                      businessProfiles: [],
                    ),
                    onLogout: () {
                      vm.logout();
                      context.go(AppRoutes.login);
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
                            index: vm.currentIndex,
                            children: const [
                              OrdersView(),
                              InventoryListView(),
                              StoresView(),
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
                height: 80,
                color: context.colorScheme.secondaryContainer,
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    children: dashboardTabs.mapIndexed((i, val) {
                      return Expanded(
                        child: _buildNavBarItem(
                          context: context,
                          isSelected: vm.currentIndex == i,
                          text: val.name,
                          icon: val.icon,
                          onPressed: () => vm.updateCurrenctIndex(i),
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
