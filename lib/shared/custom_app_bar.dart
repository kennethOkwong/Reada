import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.actions});

  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title != null
            ? Text(title!, style: context.textTheme.titleMedium)
            : null,
        centerTitle: true,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
