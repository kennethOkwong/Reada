import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';
import 'package:reada/shared/constants.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Result<User>> login({required LoginRequestDto data}) async {
    try {
      final result = await authDataSource.login(requestData: data);
      return result.map((dto) => dto.toDomain());
    } catch (e) {
      return Failure(Constants.genericError);
    }
  }

  @override
  Future<Result> register({required RegisterRequestDto data}) async {
    return await authDataSource.register(data: data);
  }

  @override
  Future<Result> verifyOTP({required VerifyCodeRequestDto data}) async {
    return await authDataSource.verifyOTP(data: data);
  }

  @override
  Future<Result> resetPassword({required ResetPasswordRequestDto data}) async {
    return await authDataSource.resetPassword(data: data);
  }

  @override
  Future<Result> sendOTP(SendCodeRequestDto data) async {
    return await authDataSource.sendOTP(data);
  }

  @override
  Future<Result> getUser() async {
    return await authDataSource.getUser();
  }
}
