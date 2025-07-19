import 'dart:async';

import 'package:reada/app/locator.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/api%20service/api_response.dart';

import 'local_storage_service.dart';

class TokenManager {
  final Api _helper = locator<Api>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  late Timer _timer;
  bool retry = true;

  void start() {
    // retry = true;
    refreshCallback();
    _timer = Timer.periodic(const Duration(minutes: 8), (_) {
      refreshCallback();
    });
  }

  void cancel() {
    _timer.cancel();
    retry = false;
  }

  Future<ApiResponse?> refreshCallback({bool recursive = false}) async {
    if (retry) {
      const url = 'user/jwt-token-refresh/';
      final refreshToken = await _localStorageService
          .getStorageValue(LocalStorageKeys.refreshToken);
      final response = await _helper.postData(
        url,
        {'refresh': refreshToken},
      );
      if (response.isSuccessful) {
        await _localStorageService.saveStorageValue(
          LocalStorageKeys.accessToken,
          response.data['access'],
        );
        return response;
      } else {
        if (recursive) {
          Future.delayed(const Duration(seconds: 2), refreshCallback);
        }
      }

      return response;
    }
    return null;
  }
}
