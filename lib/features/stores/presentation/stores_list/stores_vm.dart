import 'package:reada/app/base/base_vm.dart';

import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/usecase/store_usecase.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';

class StoresViewmodel extends BaseViewModel<StoreEvent, List<Store>> {
  List<Store> stores = [];
  Store? selectedStore;

  void onSelectStore(Store store) {
    selectedStore = store;
  }

  /// Fetch all stores for the current user
  Future<void> getStores() async {
    setLoading();
    final result = await getStoresUseCase.call();
    setIdle();
    result.when(
      success: (data, message) {
        if (data == null || data.isEmpty) {
          setEmpty();
          return;
        }
        stores.clear();
        stores.addAll(data);
      },
      failure: (exception) {
        setError(exception.toString());
      },
    );
  }
}
