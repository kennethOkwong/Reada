import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/dashboard/presentation/dashboard_event.dart';

class DashboardViewmodel extends BaseViewModel<DashboardEvent, void> {
  int currentIndex = 0;

  String get appBarTitle {
    if (currentIndex == 0) return 'Orders';
    if (currentIndex == 1) return 'Inventory';
    return 'Stores';
  }

  void updateCurrenctIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
