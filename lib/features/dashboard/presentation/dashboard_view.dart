import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/dashboard/domain/models/bottom_nav_model.dart';
import 'package:reada/features/dashboard/presentation/dashboard_event.dart';
import 'package:reada/features/dashboard/presentation/dashboard_viewmodel.dart';
import 'package:reada/shared/app%20images/svg_icons.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewmodel, DashboardEvent>(
      builder: (context, model, child) {
        return PopScope(
          canPop: model.currentIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (model.currentIndex != 0) {
              model.updateCurrenctIndex(0);
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: IndexedStack(
                  index: model.currentIndex,
                  children: const [
                    Scaffold(),
                    Scaffold(),
                    Scaffold(),
                    Scaffold(),
                    Scaffold(),
                  ],
                ),
              ),

              // Bottom Nav Bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    height: 100,
                    color: context.colorScheme.primary,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        children: dashboardTabs.mapIndexed((i, val) {
                          return Expanded(
                            child: _buildNavBarItem(
                              isSelected: model.currentIndex == i,
                              text: val.name,
                              icon: model.currentIndex == i
                                  ? val.activeIcon
                                  : val.icon,
                              onPressed: () => model.updateCurrenctIndex(i),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
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
    required String text,
    required String icon,
    required bool isSelected,
    required void Function()? onPressed,
  }) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const AppSpacing.v8(),
            SvgIcon(name: icon, size: 20),
            // const AppSpacing.v4(),
            Text(
              text,
              // style: AppTextStyle.medium12.copyWith(
              //   color: getColor,
              //   fontSize: 15.r,
              // ),
            ),
            // const AppSpacing.v8(),
          ],
        ),
      ),
    );
  }
}
