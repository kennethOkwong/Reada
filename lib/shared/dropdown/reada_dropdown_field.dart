import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

/// A customizable reusable dropdown form field styled for Reada.
///
/// ## Example
/// ```dart
/// ReadaDropdown<String>(
///   title: "Partition (optional)",
///   value: selectedPartition,
///   items: partitions.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
///   onChanged: (val) => setState(() => selectedPartition = val),
/// )
/// ```
class ReadaDropdown<T> extends StatelessWidget {
  const ReadaDropdown({
    super.key,
    this.title,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
    this.hintText,
  });

  final String? title;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isRequired;
  final bool enabled;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          RichText(
            text: TextSpan(
              text: title!,
              style: context.textTheme.titleSmall,
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        if (title != null) context.vSpacing4,
        DropdownButtonFormField<T>(
          // value: value,
          items: items,
          validator: validator,
          onChanged: enabled ? onChanged : null,
          style: context.textTheme.labelMedium?.copyWith(
            color: enabled
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            labelText: hintText,
            enabled: enabled,
            labelStyle: context.textTheme.labelMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
