import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  Future<Result> call(VerifyCodeRequestDto data) async {
    return await repository.verifyOTP(data: data);
  }
}
