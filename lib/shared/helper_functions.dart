import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HelperFunctions {
  static void showToast(String message) {
    toastification.show(
      showProgressBar: true,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
