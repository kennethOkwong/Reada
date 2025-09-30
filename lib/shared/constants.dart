import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class Constants {
  static EdgeInsetsGeometry pagePadding(BuildContext context) =>
      EdgeInsets.symmetric(
          horizontal: context.width * 0.05, vertical: context.width * 0.05);

  static String defaultPhone = '';
  static String defaultTimeStamp = "2025-08-08T00:31:23.963102Z";
  static String defaultBusinessDesc = "";
  static String defaultBusinesslogo = "";
  static String defaultBusinessBanner =
      "https://images.unsplash.com/photo-1507842217343-583bb7270b66";
  static String defaultBookCover =
      "https://m.media-amazon.com/images/I/21TsZ14+iBL.jpg";
}
