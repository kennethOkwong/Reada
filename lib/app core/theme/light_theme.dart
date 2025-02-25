import 'package:flutter/material.dart';
import 'package:reada/app%20core/theme/colors.dart';

//app general theme data
final lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
  filledButtonTheme: filledButtonLightTheme,
  outlinedButtonTheme: outlinedButtonLightTheme,
  textTheme: lightTextTheme,
);

//light theme color scheme
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.primary,
);

FilledButtonThemeData get filledButtonLightTheme {
  return FilledButtonThemeData(
      style: FilledButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ));
}

OutlinedButtonThemeData get outlinedButtonLightTheme {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
    ),
  );
}

TextTheme get lightTextTheme {
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
