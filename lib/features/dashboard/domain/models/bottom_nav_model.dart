import 'package:reada/shared/app%20images/svg_icons.dart';

class BottomNavigationModel {
  BottomNavigationModel({
    required this.icon,
    required this.name,
    required this.activeIcon,
  });
  String icon;
  String activeIcon;
  String name;
}

final dashboardTabs = [
  BottomNavigationModel(
    icon: SvgData.icStoreInactive,
    activeIcon: SvgData.icStoreActive,
    name: 'Overview',
  ),
  BottomNavigationModel(
    icon: SvgData.icStoreInactive,
    activeIcon: SvgData.icStoreActive,
    name: 'Inventory',
  ),
  BottomNavigationModel(
    icon: SvgData.icStoreInactive,
    activeIcon: SvgData.icStoreActive,
    name: 'Sales',
  ),
  BottomNavigationModel(
    icon: SvgData.icStoreInactive,
    activeIcon: SvgData.icStoreActive,
    name: 'Stores',
  ),
  BottomNavigationModel(
    icon: SvgData.icStoreInactive,
    activeIcon: SvgData.icStoreActive,
    name: 'More',
  ),
];
