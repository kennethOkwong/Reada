import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/shared/helper_functions.dart';

class GetUserFromApiUsecase {
  final AuthRepository repository;

  GetUserFromApiUsecase(this.repository);

  Future<Result<User>> call() async {
    try {
      return await repository.getUserFromApi();
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
