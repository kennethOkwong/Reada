import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reada/features/authentication/data/dtos/user_response_dto.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';

class LocalStorageKeys {
  static String refreshToken = 'refreshToken';
  static String accessToken = 'accessToken';
  static String user = 'user';
}

class LocalStorageService {
  final fSStorage = const FlutterSecureStorage();

  Future<String?> getStorageValue(String key) async {
    // Read value
    final value = await fSStorage.read(key: key);
    return value;
  }

  Future<void> saveStorageValue(String key, String value) async {
    return fSStorage.write(key: key, value: value);
  }

  Future<void> clearAllAuth() async {
    try {
      await fSStorage.delete(key: LocalStorageKeys.accessToken);
      await fSStorage.delete(key: LocalStorageKeys.refreshToken);
      await fSStorage.delete(key: LocalStorageKeys.user);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  Future<void> clearAll() async {
    try {
      return fSStorage.deleteAll();
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  Future<void> saveUser(UserDto userDto) async {
    try {
      fSStorage.write(
          key: LocalStorageKeys.user, value: jsonEncode(userDto.toJson()));
      fSStorage.write(
          key: LocalStorageKeys.accessToken, value: userDto.accessToken);
      fSStorage.write(key: LocalStorageKeys.user, value: userDto.refreshToken);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  Future<UserDto?> getUser() async {
    try {
      final value = await fSStorage.read(key: LocalStorageKeys.user);
      if (value != null) {
        return UserDto.fromJson(jsonDecode(value));
      }
      return null;
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }
}
