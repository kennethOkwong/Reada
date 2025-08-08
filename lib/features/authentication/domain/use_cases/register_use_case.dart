import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/register_user_model.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Result> call(RegisterUserDataModel data) async {
    return await repository.register(data: data);
  }
}
