import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/dashboard/presentation/dashboard_event.dart';

class DashboardViewmodel extends BaseViewModel<DashboardEvent, void> {
  int currentIndex = 0;
  void updateCurrenctIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
