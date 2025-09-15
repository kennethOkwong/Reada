import 'dart:developer' show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reada/services/api%20service/error_handling/exceptions.dart';
import 'package:toastification/toastification.dart';

class HelperFunctions {
  static void showSuccessToast(String message) {
    toastification.show(
      type: ToastificationType.success,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static void showErrorToast(String message) {
    toastification.show(
      type: ToastificationType.error,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  // Utility to check required fields
  static T requireField<T>(T? value, String fieldName) {
    if (value == null) {
      throw ReadaFormatException(message: 'Missing required field: $fieldName');
    }
    return value;
  }

  static T? safeCast<T>(dynamic value) {
    try {
      if (value == null) return null;

      if (T == String) {
        return value.toString() as T;
      } else if (T == int) {
        if (value is int) return value as T;
        if (value is String) return int.tryParse(value) as T?;
        if (value is double) return value.toInt() as T;
      } else if (T == double) {
        if (value is double) return value as T;
        if (value is int) return value.toDouble() as T;
        if (value is String) return double.tryParse(value) as T?;
      } else if (T == bool) {
        if (value is bool) return value as T;
        if (value is String) {
          final lower = value.toLowerCase();
          if (lower == 'true' || lower == '1') return true as T;
          if (lower == 'false' || lower == '0') return false as T;
        }
        if (value is num) return (value != 0) as T;
      } else if (T == DateTime) {
        if (value is DateTime) return value as T;
        if (value is String) return DateTime.tryParse(value) as T?;
      }
      // fallback: try a direct cast
      return value as T?;
    } catch (_) {
      return null;
    }
  }

  static void debugLog(dynamic error, StackTrace s) {
    if (kReleaseMode) return;
    log(error.toString(), stackTrace: s);
  }
}
