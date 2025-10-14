import 'package:reada/app/base/base_vm.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/features/stores/data/dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/usecase/store_usecase.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';

class AddStoreViewmodel extends BaseViewModel<StoreEvent, List<String>> {
  AddStoreRequestDto storeRequestData = AddStoreRequestDto.empty();
  BookcaseDto bookcaseRequestData = BookcaseDto.empty();
  Store? store;
  bool get storecreated => store != null;

  void onStoreNameChanged(String? value) {
    storeRequestData = storeRequestData.copyWith(storeName: value);
  }

  void onStoreAddressChanged(String? value) {
    storeRequestData = storeRequestData.copyWith(storeAddress: value);
  }

  void onLatitudeChanged(String? value) {
    storeRequestData = storeRequestData.copyWith(latitude: value);
  }

  void onLongitudeChanged(String? value) {
    storeRequestData = storeRequestData.copyWith(longitude: value);
  }

  void onBookcaseTitleChanged(String? value) {
    bookcaseRequestData = bookcaseRequestData.copyWith(title: value);
  }

  void onNoOfShelvesChanged(int? value) {
    bookcaseRequestData = bookcaseRequestData.copyWith(shelves: value);
  }

  Future<void> addStore() async {
    setLoading();
    final result = await addStoreUseCase.call(storeRequestData);
    setIdle();

    result.when(
      success: (storeData, message) {
        store = storeData;
        locator<StoresViewmodel>().getStores();

        emitEvent(const StoreEvent.storeAdded());
      },
      failure: (exception) {
        emitEvent(StoreEvent.failure(exception.toString()));
      },
    );
  }

  Future<void> addBookcase() async {
    setLoading();
    final result = await addBookcaseUseCase.call(bookcaseRequestData);
    setIdle();
    result.when(
      success: (data, message) {
        emitEvent(const StoreEvent.bookcaseAdded());
      },
      failure: (exception) {
        emitEvent(StoreEvent.failure(exception.toString()));
      },
    );
  }

  // Fetch all shelves in a bookcase
  Future<void> getShelves(String bookcaseId) async {
    setLoading();
    final result = await getShelvesUseCase.call(bookcaseId);
    setIdle();

    result.when(
      success: (data, message) {
        emitEvent(const StoreEvent.shelvesFetched());
      },
      failure: (exception) {
        emitEvent(StoreEvent.failure(exception.toString()));
      },
    );
  }

  // Fetch book details by ID
  Future<void> getBookDetails(String bookId) async {
    setLoading();
    final result = await getBookDetailsUseCase.call(bookId);
    setIdle();

    result.when(
      success: (data, message) {
        emitEvent(const StoreEvent.bookDetailsFetched());
      },
      failure: (exception) {
        emitEvent(StoreEvent.failure(exception.toString()));
      },
    );
  }
}
