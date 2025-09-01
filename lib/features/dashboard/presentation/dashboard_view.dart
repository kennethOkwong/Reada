import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/dashboard/domain/models/bottom_nav_model.dart';
import 'package:reada/features/dashboard/presentation/dashboard_event.dart';
import 'package:reada/features/dashboard/presentation/dashboard_viewmodel.dart';
import 'package:reada/features/stores/presentation/stores/stores_view.dart';
import 'package:reada/shared/app%20images/svg_icons.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

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
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: IndexedStack(
                        index: model.currentIndex,
                        children: [
                          Scaffold(
                            appBar: const CustomAppBar(
                              title: 'Orders',
                            ),
                            body: EmptyState(
                              title: "No Data",
                              message:
                                  "You don’t have any orders yet.\nStart by adding a local order",
                              icon: Icons.history,
                              buttonText: "Add order",
                              onButtonPressed: () {
                                // handle action
                              },
                            ),
                          ),
                          Scaffold(
                            appBar: const CustomAppBar(
                              title: 'Inventory',
                            ),
                            body: EmptyState(
                              title: "No Data",
                              message:
                                  "You don’t have any inventories yet.\nStart by adding one!",
                              icon: Icons.history,
                              buttonText: "Add inventory",
                              onButtonPressed: () {
                                // handle action
                              },
                            ),
                          ),
                          const StoresView(),
                        ],
                      ),
                    ),

                    // Bottom Nav Bar
                  ],
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
