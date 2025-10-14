import 'package:reada/app/result.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class GetStoresUseCase {
  final StoreRepository repository;

  GetStoresUseCase(this.repository);

  Future<Result<List<Store>>> call() async {
    try {
      final response = await repository.getStores();
      return Success(data: response.data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
