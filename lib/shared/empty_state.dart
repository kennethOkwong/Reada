import 'package:flutter/material.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool isError;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.width * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.error_outline_outlined : Icons.history,
              size: context.width * 0.2,
              color: context.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ReadaButton.elevated(
                title: buttonText!,
                onPressed: () {},
              )
            ]
          ],
        ),
      ),
    );
  }
}
