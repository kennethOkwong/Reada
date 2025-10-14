import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/services/services.dart';
import 'package:reada/shared/helper_functions.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<void>> call() async {
    try {
      Services.localStorageService.clearAll();
      return repository.logout();
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
