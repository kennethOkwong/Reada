import 'package:reada/app/base/base_vm.dart';

class DashboardViewmodel extends BaseViewModel {
  int currentIndex = 0;
  void updateCurrenctIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
