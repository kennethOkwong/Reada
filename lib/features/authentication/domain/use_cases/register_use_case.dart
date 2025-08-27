import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';
import 'package:reada/features/authentication/domain/use_cases/auth_use_cases.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Result> call(RegisterRequestDto data) async {
    final result = await repository.register(data: data);
    if (result.isFailure) {
      return result;
    }
    //send code if registration is successful
    sendCodeUseCase.call(data.toSendCodeDto());
    return result;
  }
}
