import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reada/app/theme/colors.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class CustomPhoneNumberField extends StatefulWidget {
  const CustomPhoneNumberField({
    required this.onNumberChange,
    super.key,
    this.title,
    this.isRequired = false,
    this.onTap,
    this.enabled = true,
    this.hintStyle,
    this.validator,
    this.fieldKey,
  });

  final String? title;
  final bool isRequired;
  final bool enabled;

  final void Function(PhoneNumber?) onNumberChange;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final GlobalKey<FormFieldState<PhoneNumber>>? fieldKey;

  @override
  State<CustomPhoneNumberField> createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
  PhoneNumber? number;
  Country selectedCountry = const Country(
    name: "Nigeria",
    nameTranslations: {
      "sk": "Nigéria",
      "se": "Nigeria",
      "pl": "Nigeria",
      "no": "Nigeria",
      "ja": "ナイジェリア",
      "it": "Nigeria",
      "zh": "尼日利亚",
      "nl": "Nigeria",
      "de": "Nigeria",
      "fr": "Nigéria",
      "es": "Nigeria",
      "en": "Nigeria",
      "pt_BR": "Nigéria",
      "sr-Cyrl": "Нигерија",
      "sr-Latn": "Nigerija",
      "zh_TW": "奈及利亞",
      "tr": "Nijerya",
      "ro": "Nigeria",
      "ar": "نيجيريا",
      "fa": "نیجریه",
      "yue": "尼日利亞"
    },
    flag: "🇳🇬",
    code: "NG",
    dialCode: "234",
    minLength: 10,
    maxLength: 11,
  );
  @override
  Widget build(BuildContext context) {
    return FormField<PhoneNumber>(
        key: widget.fieldKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (phone) {
          if (phone == null || phone.number.isEmpty) {
            return 'Please enter a valid phone number';
          }
          if (phone.number.trim().length < selectedCountry.minLength) {
            return 'Please enter a valid phone number';
          }
          if (phone.number.trim().length > selectedCountry.maxLength) {
            return 'Please enter a valid phone number';
          }
          return null;
        },
        builder: (field) {
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
              IntlPhoneField(
                  enabled: widget.enabled,

                  // validator: widget.validator,
                  disableLengthCheck: true,
                  onTap: widget.onTap,
                  // showCountryFlag: false,
                  decoration: InputDecoration(
                    enabled: widget.enabled,
                    errorText: field.errorText,
                    hintText: 'Enter number',
                    hintStyle: widget.hintStyle ??
                        context.textTheme.labelMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),

                    // isDense: true,
                    // isCollapsed: true,
                    // constraints: const BoxConstraints(
                    //   minHeight: 44,
                    // ).r,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    // label: Text('Phone'),
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
                      borderSide: BorderSide(color: AppColors.primaryBlue),
                    ),
                    filled: true,
                    fillColor:
                        widget.enabled ? Colors.transparent : AppColors.grey300,
                  ),
                  initialCountryCode: 'NG',
                  cursorColor: AppColors.primaryBlue,
                  dropdownIconPosition: IconPosition.trailing,
                  // dropdownIcon:
                  //     const Icon(Icons.expand_more, color: AppColors.blue50, size: 16),
                  flagsButtonMargin: const EdgeInsets.only(left: 12),
                  // flagsButtonPadding: const EdgeInsets.only(right: 10).r,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.grey900),
                  dropdownTextStyle: widget.enabled
                      ? context.textTheme.bodyMedium
                      : context.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.blue50),
                  textAlignVertical: TextAlignVertical.center,
                  pickerDialogStyle: PickerDialogStyle(
                      backgroundColor: Colors.white,
                      searchFieldCursorColor: AppColors.primaryBlue,
                      searchFieldInputDecoration: InputDecoration(
                        suffixIcon:
                            const Icon(Icons.search, color: AppColors.blue50),
                        hintText: 'Search Country',
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.blue50,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryBlue),
                          borderRadius: BorderRadius.zero,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.blue50),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      countryNameStyle: context.textTheme.bodyMedium
                      // countryCodeStyle: AppTextStyle.medium14,
                      ),
                  onChanged: (phone) {
                    number = phone;
                    field.didChange(number);
                    widget.onNumberChange(number);
                  },
                  onCountryChanged: (country) {
                    selectedCountry = country;
                    number?.countryCode = selectedCountry.dialCode;
                    number?.countryISOCode = selectedCountry.code;

                    field.didChange(number);
                    widget.onNumberChange(number);
                  }),
            ],
          );
        });
  }
}
