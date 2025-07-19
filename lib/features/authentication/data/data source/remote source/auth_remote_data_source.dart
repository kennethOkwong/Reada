import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/api%20service/api_response.dart';
import 'package:reada/services/api%20service/url_path.dart';

import '../../../domain/models/user_model.dart';
import '../auth_data_source.dart';

final getIt = GetIt.I;

class AuthRemoteDataSource implements AuthDataSource {
  final Api _helper = locator<Api>();

  @override
  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    final body = {
      "email": email.trim().toLowerCase(),
      "password": password,
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }

  @override
  Future<ApiResponse> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    final body = {
      "email": email.trim().toLowerCase(),
      "password": password,
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }

  @override
  Future<ApiResponse> sendOTP(String email) async {
    final body = {
      "email": email.trim().toLowerCase(),
      "password": 'password',
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }

  @override
  Future<ApiResponse> verifyOTP({
    required String pinId,
    required String otp,
  }) async {
    final body = {
      "email": pinId,
      "password": otp,
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }

  @override
  Future<ApiResponse> resetPassword({required String newPassword}) async {
    final body = {
      "email": newPassword,
      "password": newPassword,
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }

  @override
  Future<ApiResponse> getUser() async {
    final body = {
      "email": 'newPassword',
      "password": 'newPassword',
    };
    var url = UrlPath.login;
    final response = await _helper.postData(url, body);

    return response;
  }
}
