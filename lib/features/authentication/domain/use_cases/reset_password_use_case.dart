import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Result> call(ResetPasswordRequestDto data) async {
    return await repository.resetPassword(data: data);
  }
}
