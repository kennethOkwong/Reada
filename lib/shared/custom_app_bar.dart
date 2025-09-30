import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.actions,
      this.centerTitle = true,
      this.titleStyle,
      this.heroTag});

  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final TextStyle? titleStyle;
  final dynamic heroTag;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title != null
            ? heroTag != null
                ? Hero(
                    tag: heroTag,
                    child: Text(title!,
                        style: titleStyle ?? context.textTheme.titleMedium))
                : Text(title!,
                    style: titleStyle ?? context.textTheme.titleMedium)
            : null,
        centerTitle: centerTitle,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
