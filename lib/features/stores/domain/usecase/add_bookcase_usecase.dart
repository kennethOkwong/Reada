import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/dtos/request_dtos/add_bookcase_request_dto.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class AddBookcaseUseCase {
  final StoreRepository repository;

  AddBookcaseUseCase(this.repository);

  Future<Result<Bookcase?>> call(AddBookcaseRequestDto data) async {
    try {
      final response = await repository.addBookcase(requestData: data);
      return Success(data: response.data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
