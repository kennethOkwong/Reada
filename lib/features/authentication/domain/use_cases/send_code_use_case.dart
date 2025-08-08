import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/repository/auth_repository.dart';

class SendCodeUseCase {
  final AuthRepository repository;

  SendCodeUseCase(this.repository);

  Future<Result> call(SendCodeDataModel data) async {
    return await repository.sendOTP(data);
  }
}
