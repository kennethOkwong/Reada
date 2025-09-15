import 'package:flutter/material.dart';

const _lightPrimary = Color(0xFF2647B5);
const _lightSecondary = Color(0xFFF36C4C);
const _darkPrimary = Color.fromARGB(255, 4, 21, 77);
const _darkSecondary = Color.fromARGB(255, 132, 45, 25);

class ReadaColorScheme {
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: _lightPrimary,
    brightness: Brightness.light,
    primary: _lightPrimary,
    secondary: _lightSecondary,
  );

  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: _darkPrimary,
    brightness: Brightness.dark,
    primary: _darkPrimary,
    secondary: _darkSecondary,
  );
}
