import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class PinInputField extends StatelessWidget {
  const PinInputField({
    super.key,
    required this.onCompleted,
    this.validator,
    this.controller,
  });
  final Function(String pin) onCompleted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      defaultPinTheme: focusedPinTheme(context),
      focusedPinTheme: focusedPinTheme(context),
      submittedPinTheme: submittedPinTheme(context),
      validator: validator,
      showCursor: true,
      onCompleted: onCompleted,
      controller: controller,
    );
  }
}

PinTheme defaultPinTheme(BuildContext context) => PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: context.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.surface),
    );

PinTheme focusedPinTheme(BuildContext context) =>
    defaultPinTheme(context).copyDecorationWith(
      border: Border.all(color: context.colorScheme.primary),
      borderRadius: BorderRadius.circular(8),
    );

PinTheme submittedPinTheme(BuildContext context) =>
    defaultPinTheme(context).copyDecorationWith(
      border: Border.all(color: context.colorScheme.onSurface),
      borderRadius: BorderRadius.circular(8),
    );
