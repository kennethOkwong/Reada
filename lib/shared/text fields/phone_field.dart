import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reada/app/theme/color_scheme.dart';
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
    this.controller,
    this.initialValue,
  });

  final String? title;
  final bool isRequired;
  final bool enabled;

  final void Function(PhoneNumber?) onNumberChange;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final GlobalKey<FormFieldState<PhoneNumber>>? fieldKey;
  final TextEditingController? controller;
  final String? initialValue;

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pre-fill validation fix
      final text = widget.controller?.text ?? widget.initialValue ?? "";
      if (text.isNotEmpty) {
        number = PhoneNumber(
          countryCode: selectedCountry.dialCode,
          countryISOCode: selectedCountry.code,
          number: text,
        );
        widget.onNumberChange(number);

        // Force FormField to see it as changed
        widget.fieldKey?.currentState?.didChange(number);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<PhoneNumber>(
      key: widget.fieldKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (phone) {
        log("Validating phone: $phone");
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
            IntlPhoneField(
              initialValue: widget.initialValue,
              enabled: widget.enabled,
              controller: widget.controller,
              disableLengthCheck: true,
              onTap: widget.onTap,
              decoration: InputDecoration(
                enabled: widget.enabled,
                errorText: field.errorText,
                hintText: 'Enter number',
                hintStyle: widget.hintStyle ??
                    context.textTheme.labelMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  borderSide: BorderSide(color: Colors.grey),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: context.colorScheme.primary),
                ),
                filled: true,
                fillColor: widget.enabled
                    ? Colors.transparent
                    : context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              initialCountryCode: 'NG',
              cursorColor: context.colorScheme.primary,
              dropdownIconPosition: IconPosition.trailing,
              flagsButtonMargin: const EdgeInsets.only(left: 12),
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: context.colorScheme.onSurface),
              dropdownTextStyle: widget.enabled
                  ? context.textTheme.bodyMedium
                  : context.textTheme.bodyMedium
                      ?.copyWith(color: context.colorScheme.primaryContainer),
              textAlignVertical: TextAlignVertical.center,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: Colors.white,
                searchFieldCursorColor: context.colorScheme.primary,
                searchFieldInputDecoration: InputDecoration(
                  suffixIcon: Icon(Icons.search,
                      color: context.colorScheme.primaryContainer),
                  hintText: 'Search Country',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colorScheme.primary),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          context.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                countryNameStyle: context.textTheme.bodyMedium,
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
              },
            ),
          ],
        );
      },
    );
  }
}
