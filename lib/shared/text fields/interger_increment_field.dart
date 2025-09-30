import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

/// IntegerIncrementField: A customizable field for incrementing/decrementing integer values.
class IntegerIncrementField extends StatefulWidget {
  final int value;
  final int? min;
  final int? max;
  final String? title;
  final String? hintText;
  final ValueChanged<int>? onChanged;
  final bool enabled;
  final bool isRequired;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final TextStyle? valueStyle;
  final String? Function(int value, int? min, int? max)? validator;

  const IntegerIncrementField({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 9999,
    this.title,
    this.hintText,
    this.onChanged,
    this.enabled = true,
    this.isRequired = false,
    this.backgroundColor,
    this.hintStyle,
    this.valueStyle,
    this.validator,
  });

  @override
  State<IntegerIncrementField> createState() => _IntegerIncrementFieldState();
}

class _IntegerIncrementFieldState extends State<IntegerIncrementField> {
  late int _value;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller = TextEditingController(text: _value.toString());
  }

  @override
  void didUpdateWidget(covariant IntegerIncrementField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
      _controller.text = _value.toString();
    }
  }

  void _increment(FormFieldState<int> field) {
    if (widget.max != null && _value > widget.max!) {
      return;
    }
    setState(() {
      _value++;
      _controller.text = _value.toString();
    });
    field.didChange(_value);
    widget.onChanged?.call(_value);
  }

  void _decrement(FormFieldState<int> field) {
    if (widget.min != null && _value < widget.min!) {
      return;
    }
    setState(() {
      _value--;
      _controller.text = _value.toString();
    });
    field.didChange(_value);
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          RichText(
            text: TextSpan(
              text: widget.title!,
              style: context.textTheme.titleSmall,
              children: [
                if (widget.isRequired)
                  TextSpan(
                    text: '*',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        if (widget.title != null) context.vSpacing4,
        FormField<int>(
          initialValue: _value,
          validator: (val) {
            final v = val ?? _value;
            if (widget.validator != null) {
              return widget.validator!(v, widget.min, widget.max);
            }
            if (widget.min != null && v < widget.min!) {
              return 'Value must not be below ${widget.min}';
            }
            if (widget.max != null && v > widget.max!) {
              return 'Value must not be above ${widget.max}';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ReadaButton.icon(
                      enabled: widget.enabled,
                      icon: const Icon(Icons.remove),
                      onPressed: () => _decrement(field),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        controller: _controller,
                        enabled: widget.enabled,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style:
                            widget.valueStyle ?? context.textTheme.labelMedium,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: widget.hintStyle ??
                              context.textTheme.labelMedium?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                          filled: true,
                          fillColor:
                              widget.backgroundColor ?? Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onChanged: (val) {
                          final parsed = int.tryParse(val);
                          if (parsed != null) {
                            setState(() => _value = parsed);
                            field.didChange(parsed);
                            widget.onChanged?.call(parsed);
                          }
                        },
                      ),
                    ),
                    ReadaButton.icon(
                      enabled: widget.enabled,
                      icon: const Icon(Icons.add),
                      onPressed: () => _increment(field),
                    ),
                  ],
                ),
                if (field.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      field.errorText!,
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
