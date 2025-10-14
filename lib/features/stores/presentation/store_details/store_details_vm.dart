import 'package:reada/app/base/base_vm.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/usecase/store_usecase.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';

class StoreDetailsViewmodel extends BaseViewModel<StoreEvent, void> {
  Store? selectedStore;
  List<Bookcase> bookcases = [];

  void init(Store store) {
    selectedStore = store;
  }

  // Fetch all bookcases in a store
  Future<void> getBookcases(String storeId) async {
    setLoading();
    final result = await getBookcasesUseCase.call(storeId);
    setIdle();

    result.when(
      success: (data, message) {
        if (data == null || data.isEmpty) {
          setEmpty();
          return;
        }
        bookcases.clear();
        bookcases.addAll(data);
        emitEvent(const StoreEvent.bookcasesFetched());
      },
      failure: (exception) {
        emitEvent(StoreEvent.failure(exception.toString()));
      },
    );
  }
}
