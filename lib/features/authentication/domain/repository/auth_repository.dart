import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Result<User>> login({required LoginRequestDto data});
  Future<Result> register({required RegisterRequestDto data});

  Future<Result> sendOTP(SendCodeRequestDto data);

  Future<Result> verifyOTP({required VerifyCodeRequestDto data});

  Future<Result> resetPassword({required ResetPasswordRequestDto data});

  Future<Result> getUser();
}
