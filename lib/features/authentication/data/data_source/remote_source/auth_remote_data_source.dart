import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/create_business_profile_requestdto.dart';
import 'package:reada/features/authentication/data/dtos/user_response_dto.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/api%20service/error_handling/exceptions.dart';
import 'package:reada/services/api%20service/url_path.dart';
import 'package:reada/services/local_storage_service.dart';

import '../auth_data_source.dart';

final getIt = GetIt.I;

class AuthRemoteDataSource implements AuthDataSource {
  final Api _helper = locator<Api>();
  final _localStorageService = LocalStorageService();

  @override
  Future<Success<UserDto>> login({required LoginRequestDto requestData}) async {
    var url = UrlPath.login;
    final response = await _helper.postData(url, requestData.toJson());

    if (response.isSuccessful) {
      log(response.data.toString());
      final responseData = UserDto.fromJson(response.data);
      return Success(message: response.message, data: responseData);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<void>> register({required RegisterRequestDto data}) async {
    var url = UrlPath.signUp;
    final response = await _helper.postData(url, data.toJson());
    if (response.isSuccessful) {
      return Success(message: response.message);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<void>> sendOTP(SendCodeRequestDto data) async {
    var url = UrlPath.sendCode;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return Success(message: response.message);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<void>> verifyOTP({required VerifyCodeRequestDto data}) async {
    var url = UrlPath.verifyCode;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return Success(message: response.message);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<void>> resetPassword(
      {required ResetPasswordRequestDto data}) async {
    var url = UrlPath.resetPassword;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return Success(message: response.message);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<void>> createBusinesProfile(
      CreateBusinessProfileRequestDto data) async {
    var url = UrlPath.createBusinessProfile;
    final response = await _helper.postMultipleFilesData(
      url,
      data.toJson(),
      files: {'logo': data.profileImage},
      hasHeader: true,
    );

    if (response.isSuccessful) {
      return Success(message: response.message);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<UserDto>> getUserFromApi() async {
    var url = UrlPath.userDetails;
    final response = await _helper.getData(url);
    if (response.isSuccessful) {
      final responseData = UserDto.fromJson(response.data);
      return Success(message: response.message, data: responseData);
    }
    throw response.toReadaFalseApiResponseException();
  }

  @override
  Future<Success<UserDto>> getUserFromLocalStorage() async {
    final response = await _localStorageService.getUser();
    if (response != null) {
      return Success(data: response);
    }
    throw ReadaLocalStorageNoDataException();
  }

  @override
  Future<Success<void>> saveUserToLocalStorage(UserDto userDto) async {
    await _localStorageService.saveUser(userDto);
    return const Success();
  }

  @override
  Future<Success<void>> clearLocalStorage() async {
    await _localStorageService.clearAll();
    return const Success();
  }

  @override
  Future<Success<void>> clearLocalStorageAuth() async {
    await _localStorageService.clearAllAuth();
    return const Success();
  }
}
