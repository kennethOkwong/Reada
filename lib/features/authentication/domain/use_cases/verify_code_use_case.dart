import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';

import '../../../../shared/helper_functions.dart';

class VerifyCodeUseCase {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  Future<Result<void>> call(VerifyCodeRequestDto data) async {
    try {
      return await repository.verifyOTP(data: data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
