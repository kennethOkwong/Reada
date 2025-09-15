import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/services/api%20service/error_handling/exceptions.dart';
import 'package:reada/shared/helper_functions.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Result<User>> call(LoginRequestDto data) async {
    try {
      final user = await repository.login(data: data);
      if (!user.data!.isActive) {
        return const Failure(ReadaInacticeUserException());
      }

      if (!user.data!.isVerified) {
        sendCodeUseCase.call(data.toSendCodeDto());
      }

      ///Save user details when login is succesfull
      await saveUserToLocalStorageUsecase.call(user.data!);
      return user;
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
