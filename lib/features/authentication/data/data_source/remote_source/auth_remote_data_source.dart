import 'package:get_it/get_it.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/domain/entities/login_data_model.dart';
import 'package:reada/features/authentication/domain/entities/register_user_model.dart';
import 'package:reada/features/authentication/domain/entities/reset_password_data_model.dart';
import 'package:reada/features/authentication/domain/entities/send_code_data_model.dart';
import 'package:reada/features/authentication/domain/entities/verify_code_data_model.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/api%20service/api_response.dart';
import 'package:reada/services/api%20service/url_path.dart';

import '../auth_data_source.dart';

final getIt = GetIt.I;

class AuthRemoteDataSource implements AuthDataSource {
  final Api _helper = locator<Api>();

  @override
  Future<ApiResponse> login({required LoginDataModel data}) async {
    var url = UrlPath.login;
    final response = await _helper.postData(url, data.toJson());

    return response;
  }

  @override
  Future<Result> register({required RegisterUserDataModel data}) async {
    var url = UrlPath.signUp;
    final response = await _helper.postData(url, data.toJson());
    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<Result> sendOTP(SendCodeDataModel data) async {
    var url = UrlPath.sendCode;
    final response = await _helper.postData(url, data.toJson());

    if (response.isSuccessful) {
      return const Success();
    }
    return Failure(response.message);
  }

  @override
  Future<ApiResponse> verifyOTP({required VerifyCodeDataModel data}) async {
    var url = UrlPath.verifyCode;
    final response = await _helper.postData(url, data.toJson());

    return response;
  }

  @override
  Future<ApiResponse> resetPassword(
      {required ResetPasswordDataModel data}) async {
    var url = UrlPath.resetPassword;
    final response = await _helper.postData(url, data.toJson());

    return response;
  }

  @override
  Future<ApiResponse> getUser() async {
    final body = {
      "email": 'newPassword',
      "password": 'newPassword',
    };
    var url = UrlPath.signUp;
    final response = await _helper.postData(url, body);

    return response;
  }
}
