import 'package:reada/app/base/base_vm.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/features/stores/data/dtos/request_dtos/add_bookcase_request_dto.dart';
import 'package:reada/features/stores/domain/usecase/store_usecase.dart';
import 'package:reada/features/stores/presentation/store_details/store_details_vm.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';

class AddBookcaseViewmodel extends BaseViewModel<StoreEvent, void> {
  AddBookcaseRequestDto bookcaseRequestData = AddBookcaseRequestDto.empty();

  void init(int storeId) {
    bookcaseRequestData = bookcaseRequestData.copyWith(storeId: storeId);
  }

  void onBookcaseTitleChanged(String? value) {
    bookcaseRequestData = bookcaseRequestData.copyWith(title: value);
  }

  void onNoOfShelvesChanged(int? value) {
    bookcaseRequestData = bookcaseRequestData.copyWith(shelvesCount: value);
  }

  Future<void> addBookcase() async {
    setLoading();
    final result = await addBookcaseUseCase.call(bookcaseRequestData);
    setIdle();
    result.when(
      success: (data, message) {
        locator<StoreDetailsViewmodel>().getBookcases();
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
