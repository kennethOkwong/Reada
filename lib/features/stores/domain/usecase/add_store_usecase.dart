import 'package:reada/app/locator.dart';
import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class AddStoreUseCase {
  final StoreRepository repository;

  AddStoreUseCase(this.repository);

  Future<Result<Store?>> call(AddStoreRequestDto data) async {
    try {
      final response = await repository.addStore(data: data);
      return Success(data: response.data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
