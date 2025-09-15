import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';

import '../../../../shared/helper_functions.dart';

class SendCodeUseCase {
  final AuthRepository repository;

  SendCodeUseCase(this.repository);

  Future<Result<void>> call(SendCodeRequestDto data) async {
    try {
      return await repository.sendOTP(data);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
