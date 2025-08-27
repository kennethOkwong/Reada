import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class SendCodeUseCase {
  final AuthRepository repository;

  SendCodeUseCase(this.repository);

  Future<Result> call(SendCodeRequestDto data) async {
    return await repository.sendOTP(data);
  }
}
