import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reada/app%20core/theme/colors.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

/// The [PrimaryTextField] is a versatile and customizable Flutter widget that simplifies
/// the process of user input. It allows for various configurations such as validation, text obscuring,
/// and formatting, making it suitable for various use cases, including passwords and general text input.

/// ##Key features
/// * Customizable Appearance:
///   Supports prefix and suffix icons, customizable background color, and text styles, allowing for
///   seamless integration with your app's design.

/// * Validation Support:
///   Easily implement input validation with a customizable validator function, enabling you to enforce
/// rules based on your application's requirements.

/// * Password Management:
///   Option to obscure text for password fields, with an intuitive toggle visibility feature.

/// * Dynamic Callbacks:
///   Includes callbacks for text changes, submission, and editing completion to handle user interactions
///   in real-time.

/// * Flexible Input Options:
///   Supports various keyboard types, input formatters, and constraints for maximum and minimum lines,
///   making it adaptable for different input scenarios.

/// * Initial Text Support:
///   Can start with predefined text values and maintain control through a [TextEditingController].
class PrimaryTextField extends StatefulWidget {
  /// The [PrimaryTextField] is a versatile and customizable Flutter widget that simplifies
  /// the process of user input. It allows for various configurations such as validation, text obscuring,
  /// and formatting, making it suitable for various use cases, including passwords and general text input.
  ///
  /// ##Example
  /// ```dart
  /// PrimaryTextField(
  ///   title: "Email",
  ///   hintText: "Enter your email",
  ///   controller: TextEditingController(),
  ///   keyboardType: TextInputType.emailAddress,
  ///   validator: (value) {
  ///     if (value == null || value.isEmpty) {
  ///       return "Email is required";
  ///     }
  ///     return null;
  ///   },
  ///   onChanged: (value) {
  ///     print("Current input: $value");
  ///   },
  ///   isRequired: true,
  /// )
  /// ```
  const PrimaryTextField({
    this.title,
    super.key,
    this.name,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.autoValidate = false,
    this.isPassword = false,
    this.validator,
    // this.validatorRecord,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
    this.textColor = Colors.grey,
    this.enabled = true,
    this.isRequired = false,
    this.maxLines = 1,
    this.initialText,
    this.minLines = 1,
    this.maxLength,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardType = TextInputType.name,
    this.outterSuffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.hintStyle,
  });

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final String? title;
  final String? name;
  final String? initialText;
  final Widget? suffixIcon;
  final Widget? outterSuffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool autoValidate;
  final bool isPassword;
  final bool isRequired;
  final Color textColor;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  // final String? Function(String?)? validator;
  final (bool, String?)? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSubmitted;
  final Color? backgroundColor;
  final TextStyle? hintStyle;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  final _formFieldKey = GlobalKey<FormFieldState<String>>();
  bool obscureText = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  void updateVisibility() {
    obscureText = !obscureText;
    setState(() {});
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
              style: context.textTheme.titleSmall?.copyWith(
                  // color: widget.textColor,
                  ),
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
        Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  disabledColor: Colors.grey.shade300,
                ),
                child: Container(
                  color: !widget.enabled
                      ? Colors.grey.shade50
                      : widget.backgroundColor,
                  child: TextFormField(
                    onFieldSubmitted: widget.onSubmitted,
                    key: _formFieldKey,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: widget.controller,
                    obscureText: obscureText,
                    initialValue: widget.initialText,
                    cursorColor: AppColors.primary,
                    validator: (val) {
                      final response = widget.validator?.call(val);
                      hasError = response?.$1 ?? false;
                      return response?.$2;
                    },
                    inputFormatters: widget.inputFormatters,
                    enabled: widget.enabled,
                    onChanged: (val) {
                      if (widget.autoValidate) {
                        _formFieldKey.currentState!.validate();
                      }
                      widget.onChanged?.call(val);
                    },
                    maxLines: widget.maxLines,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    cursorHeight: 20,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: widget.enabled
                          ? Colors.grey.shade900
                          : Colors.grey.shade500,
                    ),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        minHeight: 44,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      prefixIcon: widget.prefixIcon,
                      // prefixIconConstraints: const BoxConstraints(
                      //   minHeight: 32,
                      //   minWidth: 32,
                      // ).r,
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              onPressed: updateVisibility,
                              icon: Icon(
                                obscureText
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill,
                              ),
                            )
                          : widget.suffixIcon,
                      hintText: widget.hintText,
                      hintStyle: widget.hintStyle ??
                          context.textTheme.labelMedium?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.outterSuffixIcon != null) ...[
              context.hSpacing8,
              widget.outterSuffixIcon!,
            ],
          ],
        ),
      ],
    );
  }
}
