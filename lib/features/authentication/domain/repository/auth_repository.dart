import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/login_data_model.dart';
import 'package:reada/features/authentication/domain/entities/register_user_model.dart';
import 'package:reada/features/authentication/domain/entities/reset_password_data_model.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/entities/verify_code_data_model.dart';
import 'package:reada/services/api%20service/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse> login({required LoginDataModel data});
  Future<Result> register({required RegisterUserDataModel data});

  Future<Result> sendOTP(SendCodeDataModel data);

  Future<ApiResponse> verifyOTP({required VerifyCodeDataModel data});

  Future<ApiResponse> resetPassword({required ResetPasswordDataModel data});

  Future<ApiResponse> getUser();
}
