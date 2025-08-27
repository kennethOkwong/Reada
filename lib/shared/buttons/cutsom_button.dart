import 'package:flutter/material.dart';
import 'package:reada/app/theme/theme.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

enum ButtonType { filled, outlined, text }

class ReadaButton extends StatelessWidget {
  const ReadaButton.filled({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius,
    this.enabled = true,
    this.width,
  }) : type = ButtonType.filled;

  const ReadaButton.outlined({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius,
    this.enabled = true,
    this.width,
  }) : type = ButtonType.outlined;

  const ReadaButton.text({
    super.key,
    required this.title,
    required this.onPressed,
    this.enabled = true,
    this.width,
  })  : type = ButtonType.text,
        borderRadius = 0;

  final ButtonType type;
  final String title;
  final VoidCallback onPressed;
  final double? borderRadius;
  final bool enabled;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.outlined) {
      return Container(
        width: width,
        constraints: const BoxConstraints(minHeight: 50),
        child: OutlinedButton(
          onPressed: () {
            if (!enabled) return;
            onPressed();
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
          child: Text(
            title,
            style: context.textTheme.labelMedium,
          ),
        ),
      );
    }
    if (type == ButtonType.filled) {
      return Container(
        width: width,
        constraints: const BoxConstraints(minHeight: 50),
        child: FilledButton(
          onPressed: () {
            if (!enabled) return;
            onPressed();
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
          child: Text(
            title,
            style: context.textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
        ),
      );
    }
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 50),
      child: TextButton(
        onPressed: () {
          if (!enabled) return;
          onPressed();
        },
        child: Text(
          title,
          style: context.textTheme.labelMedium!.copyWith(
            color: readaAppThemeNotifier.isLight
                ? context.colorScheme.primary
                : context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
