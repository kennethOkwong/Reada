import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius,
  }) : isOutlined = false;

  const PrimaryButton.outlined({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius,
  }) : isOutlined = true;

  final bool isOutlined;
  final String title;
  final VoidCallback onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return Container(
        constraints: const BoxConstraints(minHeight: 50),
        child: OutlinedButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
          child: Text(title),
        ),
      );
    }
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
