import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get spacing2 => width * 0.50 / 100;
  double get spacing4 => width * 1.01 / 100;
  double get spacing8 => width * 2.03 / 100;
  double get spacing16 => width * 4.18 / 100;
  double get spacing20 => width * 5.09 / 100;
  double get spacing24 => width * 6.11 / 100;
  double get spacing30 => width * 7.67 / 100;
  double get spacing32 => width * 8.15 / 100;

  Widget get hSpacing2 => SizedBox(width: spacing2);
  Widget get hSpacing4 => SizedBox(width: spacing4);
  Widget get hSpacing8 => SizedBox(width: spacing8);
  Widget get hSpacing16 => SizedBox(width: spacing16);
  Widget get hSpacing20 => SizedBox(width: spacing20);
  Widget get hSpacing24 => SizedBox(width: spacing24);
  Widget get hSpacing30 => SizedBox(width: spacing30);
  Widget get hSpacing32 => SizedBox(width: spacing32);

  Widget get vSpacing2 => SizedBox(height: spacing2);
  Widget get vSpacing4 => SizedBox(height: spacing4);
  Widget get vSpacing8 => SizedBox(height: spacing8);
  Widget get vSpacing16 => SizedBox(height: spacing16);
  Widget get vSpacing20 => SizedBox(height: spacing20);
  Widget get vSpacing24 => SizedBox(height: spacing24);
  Widget get vSpacing30 => SizedBox(height: spacing30);
  Widget get vSpacing32 => SizedBox(height: spacing32);
}
