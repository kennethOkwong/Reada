import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/login_data_model.dart';
import 'package:reada/features/authentication/domain/entities/register_user_model.dart';
import 'package:reada/features/authentication/domain/entities/reset_password_data_model.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/entities/verify_code_data_model.dart';
import 'package:reada/services/api%20service/api_response.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<ApiResponse> login({required LoginDataModel data}) async {
    return await authDataSource.login(data: data);
  }

  @override
  Future<Result> register({required RegisterUserDataModel data}) async {
    return await authDataSource.register(data: data);
  }

  @override
  Future<ApiResponse> verifyOTP({required VerifyCodeDataModel data}) async {
    return await authDataSource.verifyOTP(data: data);
  }

  @override
  Future<ApiResponse> resetPassword(
      {required ResetPasswordDataModel data}) async {
    return await authDataSource.resetPassword(data: data);
  }

  @override
  Future<Result> sendOTP(SendCodeDataModel data) async {
    return await authDataSource.sendOTP(data);
  }

  @override
  Future<ApiResponse> getUser() async {
    return await authDataSource.getUser();
  }
}
