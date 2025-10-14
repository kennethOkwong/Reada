import 'package:reada/app/result.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class GetBookcasesUseCase {
  final StoreRepository repository;

  GetBookcasesUseCase(this.repository);

  Future<Result<List<Bookcase>>> call(String storeId) async {
    try {
      final response = await repository.getBookcases(storeId: storeId);
      return Success(data: response.data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
