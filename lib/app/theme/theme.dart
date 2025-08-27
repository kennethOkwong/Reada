import 'package:flutter/material.dart';
import 'package:reada/app/theme/color_scheme.dart';
import 'package:reada/app/theme/text_theme.dart';

class ReadaTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode thememode) {
    _themeMode = thememode;
    notifyListeners();
  }

  void darkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void lightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isLight => _themeMode == ThemeMode.light;

  static ThemeData lightTheme = ThemeData(
    colorScheme: ReadaColorScheme.lightColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: ReadaTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ReadaColorScheme.darkColorScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: ReadaTextTheme.darkTextTheme,
  );
}

final readaAppThemeNotifier = ReadaTheme();
