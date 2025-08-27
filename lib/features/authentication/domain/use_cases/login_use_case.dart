import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Result<User>> call(LoginRequestDto data) async {
    return await repository.login(data: data);
  }
}
