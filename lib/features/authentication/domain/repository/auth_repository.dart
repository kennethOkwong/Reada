import 'package:reada/services/api%20service/api_response.dart';

import '../models/user_model.dart';

abstract class AuthRepository {
  Future<ApiResponse> login({
    required String email,
    required String password,
  });
  Future<ApiResponse> register({
    required String email,
    required String phone,
    required String password,
  });

  Future<ApiResponse> sendOTP(String email);

  Future<ApiResponse> verifyOTP({
    required String pinId,
    required String otp,
  });

  Future<ApiResponse> resetPassword({required String newPassword});

  Future<ApiResponse> getUser();
}
