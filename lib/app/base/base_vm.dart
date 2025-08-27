import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel<E> extends ChangeNotifier {
  String errorMessage = '';
  String loadingText = '';
  bool isLoading = false;

  final StreamController<E> _eventController = StreamController<E>.broadcast();
  Stream<E> get eventStream => _eventController.stream;

  void emitEvent(E event) {
    _eventController.add(event);
  }

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

  void startLoader([String? text]) {
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
