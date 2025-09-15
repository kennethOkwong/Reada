import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/create_business_profile_requestdto.dart';
import 'package:reada/features/authentication/data/dtos/user_response_dto.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';

abstract class AuthDataSource {
  Future<Success<UserDto>> login({required LoginRequestDto requestData});
  Future<Success<void>> register({required RegisterRequestDto data});

  Future<Success<void>> sendOTP(SendCodeRequestDto data);
  Future<Success<void>> verifyOTP({required VerifyCodeRequestDto data});

  Future<Success<void>> resetPassword({required ResetPasswordRequestDto data});

  Future<Success<UserDto>> getUserFromApi();
  Future<Success<UserDto>> getUserFromLocalStorage();
  Future<Success<void>> saveUserToLocalStorage(UserDto userDto);
  Future<Success<void>> createBusinesProfile(
      CreateBusinessProfileRequestDto data);

  Future<Success<void>> clearLocalStorage();
  Future<Success<void>> clearLocalStorageAuth();
}
