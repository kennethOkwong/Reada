import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgData {
  static const String _path = 'assets/svgs';
  String get path => _path;
  static const String appLogo = '$_path/logo.svg';

  static const String icStoreActive = '$_path/ic_store_active.svg';
  static const String icStoreInactive = '$_path/ic_store_inactive.svg';
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    required this.name,
    super.key,
    this.size,
    this.iconColor,
    this.padding,
    this.bgColor,
    this.onPressed,
    this.isCircular = false,
    this.isAssetImage = true,
  });

  const SvgIcon.asset({
    required this.name,
    super.key,
    this.size,
    this.iconColor,
    this.padding,
    this.bgColor,
    this.onPressed,
    this.isCircular = false,
  }) : isAssetImage = true;

  const SvgIcon.network({
    required this.name,
    super.key,
    this.size,
    this.iconColor,
    this.padding,
    this.bgColor,
    this.onPressed,
    this.isCircular = false,
  }) : isAssetImage = false;

  final String name;
  final double? size;
  final Color? iconColor;
  final Color? bgColor;
  final bool isCircular;
  final EdgeInsets? padding;
  final void Function()? onPressed;
  final bool isAssetImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size ?? 48,
        width: size ?? 48,
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: isAssetImage
            ? SvgPicture.asset(name, color: iconColor)
            : SvgPicture.network(name, color: iconColor),
      ),
    );
  }
}
