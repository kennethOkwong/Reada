import 'package:flutter/material.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/services/navigation%20service/navigation_service.dart';

class Constants {
  static NavigationService navigationService = locator<NavigationService>();
  static EdgeInsetsGeometry pagePadding =
      const EdgeInsets.symmetric(horizontal: 15);
}
