import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';

import '../../../../shared/helper_functions.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Result<void>> call(RegisterRequestDto data) async {
    try {
      final response = await repository.register(data: data);

      //send code if registration is successful
      //it's response not really needed, user can resend code if it fails
      sendCodeUseCase.call(data.toSendCodeDto());

      //login with user details so the token can be saved to local storage
      //token will be used when user is adding a business profile
      loginUseCase.call(data.toLoginDto());
      return response;
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
