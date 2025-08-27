import 'package:flutter/material.dart';

class ReadaTextTheme {
  static TextTheme get lightTextTheme {
    return TextTheme(
      bodyMedium: ThemeData.light().textTheme.bodyMedium,
      titleSmall: ThemeData.light().textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.normal,
            wordSpacing: 2,
            letterSpacing: 1,
            height: 1.7,
          ),
      titleLarge: ThemeData.light().textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.normal,
            wordSpacing: 2,
            letterSpacing: 1,
            height: 1.7,
          ),
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyMedium: ThemeData.dark().textTheme.bodyMedium,
      titleSmall: ThemeData.dark().textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.normal,
            wordSpacing: 2,
            letterSpacing: 1,
            height: 1.7,
          ),
      titleLarge: ThemeData.dark().textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.normal,
            wordSpacing: 2,
            letterSpacing: 1,
            height: 1.7,
          ),
    );
  }
}
