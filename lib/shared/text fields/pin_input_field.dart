import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:reada/app/theme/colors.dart';

class PinInputField extends StatelessWidget {
  const PinInputField({
    super.key,
    required this.onCompleted,
    this.validator,
  });
  final Function(String pin) onCompleted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      defaultPinTheme: focusedPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: validator,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20, color: AppColors.black, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.transparent),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.blue200),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: AppColors.blue50,
  ),
);
