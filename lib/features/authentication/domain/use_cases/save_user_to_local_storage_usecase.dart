import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class SaveUserToLocalStorageUsecase {
  final AuthRepository repository;

  SaveUserToLocalStorageUsecase(this.repository);

  Future<Result<void>> call(User user) async {
    try {
      return await repository.saveUserToLocalStorage(user);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
