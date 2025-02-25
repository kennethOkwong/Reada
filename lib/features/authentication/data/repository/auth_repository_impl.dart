import 'package:reada/services/api%20service/api_response.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    return await authDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<ApiResponse> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    return await authDataSource.register(
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<ApiResponse> verifyOTP({
    required String pinId,
    required String otp,
  }) async {
    return await authDataSource.verifyOTP(pinId: pinId, otp: otp);
  }

  @override
  Future<ApiResponse> resetPassword({required String newPassword}) async {
    return await authDataSource.resetPassword(newPassword: newPassword);
  }

  @override
  Future<ApiResponse> sendOTP(String email) async {
    return await authDataSource.sendOTP(email);
  }

  @override
  Future<ApiResponse> getUser() async {
    return await authDataSource.getUser();
  }
}
