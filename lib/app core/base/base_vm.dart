import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  String errorMessage = '';
  String loadingText = '';
  bool isLoading = false;
  // LocalStorageService storageService = getIt<LocalStorageService>();
  // AuthRepository userRepository = getIt<AuthRepository>();
  // UserLocalStorage userServices = getIt<UserLocalStorage>();

  void setErrorMessage(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = '';
    notifyListeners();
  }

  void setLoadingText(String text) {
    loadingText = text;
    notifyListeners();
  }

  void clearLoadingText() {
    loadingText = '';
    notifyListeners();
  }

  void startLoader(String? text) {
    if (!isLoading) {
      isLoading = true;
      setLoadingText(text ?? '');
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      clearLoadingText();
      notifyListeners();
    }
  }
}
