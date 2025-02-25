import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reada/app%20core/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageKeys {
  static String refreshToken = 'refreshToken';
  static String accessToken = 'accessToken';
  static String expiresIn = 'expiresIn';
}

class LocalStorageService {
  static String? refreshToken;
  static String? accessToken;
  final SharedPreferences sharedPreferences = locator<SharedPreferences>();
  final fSStorage = const FlutterSecureStorage();

  Future<String?> getStorageValue(String key) async {
// Read value
    final value = await fSStorage.read(key: key);
    return value;
  }

  Future<void> saveStorageValue(String key, String value) async {
    return fSStorage.write(key: key, value: value);
  }

  Future<void> clearAuthAll() async {
    await fSStorage.delete(key: LocalStorageKeys.accessToken);
    await fSStorage.delete(key: LocalStorageKeys.refreshToken);
    await fSStorage.delete(key: LocalStorageKeys.expiresIn);
  }

  Future<void> clearAll() async => fSStorage.deleteAll();

  Future<bool> saveBoolData(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  Future<bool?> getBoolData(String key) async {
    final value = sharedPreferences.getBool(key);
    return value;
  }

  Future<bool> setStringListData(String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringListData(String key) {
    return sharedPreferences.getStringList(key);
  }
}
