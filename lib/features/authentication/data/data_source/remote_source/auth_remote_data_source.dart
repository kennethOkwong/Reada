import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/login_response_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/api%20service/url_path.dart';
import 'package:reada/shared/constants.dart';

import '../auth_data_source.dart';

final getIt = GetIt.I;

class AuthRemoteDataSource implements AuthDataSource {
  final Api _helper = locator<Api>();

  @override
  Future<Result<LoginResponseDto>> login(
      {required LoginRequestDto requestData}) async {
    try {
      var url = UrlPath.login;
      final response = await _helper.postData(url, requestData.toJson());
      if (response.isSuccessful) {
        final responseData = LoginResponseDto.fromJson(response.data);
        return Success(responseData);
      }
      return Failure(response.message);
    } catch (e) {
      return Failure(Constants.genericError);
    }
  }

  @override
  Future<Result> register({required RegisterRequestDto data}) async {
    var url = UrlPath.signUp;
    final response = await _helper.postData(url, data.toJson());
    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<Result> sendOTP(SendCodeRequestDto data) async {
    var url = UrlPath.sendCode;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<Result> verifyOTP({required VerifyCodeRequestDto data}) async {
    var url = UrlPath.verifyCode;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<Result> resetPassword({required ResetPasswordRequestDto data}) async {
    var url = UrlPath.resetPassword;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<Result> getUser() async {
    final body = {
      "email": 'newPassword',
      "password": 'newPassword',
    };
    var url = UrlPath.signUp;
    final response = await _helper.postData(url, body);
    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }
}
