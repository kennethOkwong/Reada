import 'package:reada/shared/app%20images/svg_icons.dart';

class BottomNavigationModel {
  BottomNavigationModel({
    required this.icon,
    required this.name,
  });
  String icon;
  String name;
}

final dashboardTabs = [
  // BottomNavigationModel(
  //   icon: SvgData.icStoreInactive,
  //   activeIcon: SvgData.icStoreActive,
  //   name: 'Overview',
  // ),
  BottomNavigationModel(
    icon: SvgData.icOrders,
    name: 'Orders',
  ),
  BottomNavigationModel(
    icon: SvgData.icInventory,
    name: 'Inventory',
  ),
  BottomNavigationModel(
    icon: SvgData.icStore,
    name: 'Stores',
  ),
  // BottomNavigationModel(
  //   icon: SvgData.icStoreInactive,
  //   activeIcon: SvgData.icStoreActive,
  //   name: 'More',
  // ),
];
