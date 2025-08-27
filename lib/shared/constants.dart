import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class Constants {
  static EdgeInsetsGeometry pagePadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: context.width * 0.05);

  static String defaultPhone = '';
  static String defaultTimeStamp = "2025-08-08T00:31:23.963102Z";
  static String genericError = "An error occured, please try again later";
}
