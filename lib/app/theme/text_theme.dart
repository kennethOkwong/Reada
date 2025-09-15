import 'package:flutter/material.dart';

class ReadaTextTheme {
  static TextTheme get lightTextTheme {
    return TextTheme(
      bodyMedium: ThemeData.light().textTheme.bodyMedium,
      titleSmall: ThemeData.light().textTheme.titleSmall,
      titleLarge: ThemeData.light().textTheme.titleLarge,
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyMedium: ThemeData.dark().textTheme.bodyMedium,
      titleSmall: ThemeData.dark().textTheme.titleSmall,
      titleLarge: ThemeData.dark().textTheme.titleLarge,
    );
  }
}
