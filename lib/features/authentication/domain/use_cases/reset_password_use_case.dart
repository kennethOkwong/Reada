import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';

import '../../../../shared/helper_functions.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Result<void>> call(ResetPasswordRequestDto data) async {
    try {
      return await repository.resetPassword(data: data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
