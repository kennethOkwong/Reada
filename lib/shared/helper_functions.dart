import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HelperFunctions {
  static void showSuccessToast(String message) {
    toastification.show(
      type: ToastificationType.success,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static void showErrorToast([String? message]) {
    toastification.show(
      type: ToastificationType.error,
      title: Text(message ?? 'An error occured'),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
