import 'package:reada/app/result.dart';
import 'package:reada/features/authentication/data/dtos/create_business_profile_requestdto.dart';
import 'package:reada/features/authentication/data/dtos/user_response_dto.dart';
import 'package:reada/features/authentication/data/dtos/login_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/register_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/reset_password_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/send_code_request_dto.dart';
import 'package:reada/features/authentication/data/dtos/verify_code_request_dto.dart';
import 'package:reada/features/authentication/domain/entities/user.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Success<User>> login({required LoginRequestDto data}) async {
    final response = await authDataSource.login(requestData: data);
    final domain = response.data!.toDomain();
    return Success(data: domain);
  }

  @override
  Future<Success<void>> register({required RegisterRequestDto data}) async {
    return await authDataSource.register(data: data);
  }

  @override
  Future<Success<void>> verifyOTP({required VerifyCodeRequestDto data}) async {
    return await authDataSource.verifyOTP(data: data);
  }

  @override
  Future<Success<void>> resetPassword(
      {required ResetPasswordRequestDto data}) async {
    return await authDataSource.resetPassword(data: data);
  }

  @override
  Future<Success<void>> sendOTP(SendCodeRequestDto data) async {
    return await authDataSource.sendOTP(data);
  }

  @override
  Future<Success<void>> createBusinesProfile(
      CreateBusinessProfileRequestDto data) {
    return authDataSource.createBusinesProfile(data);
  }

  @override
  Future<Success<User>> getUserFromApi() async {
    final response = await authDataSource.getUserFromApi();
    final domain = response.data!.toDomain();
    return Success(data: domain);
  }

  @override
  Future<Success<User>> getUserFromLocalStorage() async {
    final response = await authDataSource.getUserFromLocalStorage();
    final domain = response.data!.toDomain();
    return Success(data: domain);
  }

  @override
  Future<Success<void>> saveUserToLocalStorage(User user) {
    final dto = UserDto.fromDomain(user);
    return authDataSource.saveUserToLocalStorage(dto);
  }

  @override
  Future<Success<void>> clearLocalStorage() {
    return authDataSource.clearLocalStorage();
  }

  @override
  Future<Success<void>> clearLocalStorageAuth() {
    return authDataSource.clearLocalStorage();
  }
}
