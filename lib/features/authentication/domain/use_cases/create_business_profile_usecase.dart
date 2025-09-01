import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/create_business_profile_requestdto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import '../../../../shared/helper_functions.dart';

class CreateBusinessProfileUsecase {
  final AuthRepository repository;

  CreateBusinessProfileUsecase(this.repository);

  Future<Result<User?>> call(CreateBusinessProfileRequestDto data) async {
    try {
      await repository.createBusinesProfile(data);
      final userResponse = await getUserFromApiUsecase.call();
      if (userResponse.isFailure) {
        return const Success(data: null);
      }
      final user = (userResponse as Success<User>).data!;
      final storageResponse = await saveUserToLocalStorageUsecase.call(user);
      if (storageResponse.isFailure) {
        return const Success(data: null);
      }
      return Success(data: user);
    } catch (e, s) {
      HelperFunctions.debugLog(e, s);
      final readaException = ExceptionHandler.mapToReadaException(e, s);
      return Failure(readaException);
    }
  }
}
