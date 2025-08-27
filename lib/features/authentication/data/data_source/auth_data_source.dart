import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/login_response_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';

abstract class AuthDataSource {
  Future<Result<LoginResponseDto>> login(
      {required LoginRequestDto requestData});
  Future<Result> register({required RegisterRequestDto data});

  Future<Result> sendOTP(SendCodeRequestDto data);
  Future<Result> verifyOTP({required VerifyCodeRequestDto data});

  Future<Result> resetPassword({required ResetPasswordRequestDto data});

  Future<Result> getUser();
}
