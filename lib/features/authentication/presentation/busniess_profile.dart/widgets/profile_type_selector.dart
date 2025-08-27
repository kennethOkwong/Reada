import 'package:flutter/material.dart';
import 'package:reada/shared/enums/profile_type_enum.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class ProfileTypeSelector extends FormField<String> {
  ProfileTypeSelector({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    ValueChanged<ProfileType?>? onChanged,
    required BuildContext context,
  }) : super(
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile type",
                  style: context.textTheme.titleSmall?.copyWith(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: ProfileType.values.map((type) {
                    final isSelected = state.value == type.value;
                    return _CardWidget(
                      type: type,
                      state: state,
                      isSelected: isSelected,
                      onChanged: onChanged,
                    );
                  }).toList(),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.type,
    required this.state,
    this.onChanged,
    required this.isSelected,
  });

  final ProfileType type;
  final FormFieldState<String> state;
  final ValueChanged<ProfileType?>? onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!type.enabled) return;
        state.didChange(type.value);
        if (onChanged != null) {
          onChanged!(type);
        }
      },
      child: Stack(
        children: [
          Container(
            width: context.width * 0.25,
            height: context.width * 0.15,
            margin: EdgeInsets.all(context.width * 0.02),
            decoration: BoxDecoration(
              color: (context.isDarkTheme && isSelected)
                  ? context.colorScheme.primary
                  : null,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? context.colorScheme.primary : Colors.grey,
                width: isSelected ? 1 : 0.8,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type.icon,
                  size: 20,
                  color: type.enabled
                      ? (isSelected
                          ? context.isLightTheme
                              ? context.colorScheme.primary
                              : context.colorScheme.onSurface
                          : context.colorScheme.onSurface)
                      : Colors.grey,
                ),
                const SizedBox(height: 2),
                Text(type.label,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: type.enabled
                          ? context.colorScheme.onSurface
                          : Colors.grey,
                    )),
              ],
            ),
          ),

          // Overlay for "Coming Soon"
          if (!type.enabled)
            Container(
              width: context.width * 0.25,
              height: context.width * 0.15,
              margin: EdgeInsets.all(context.width * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colorScheme.onSurface.withValues(alpha: 0.3)),
              child: Center(
                child: Text(
                  "Coming soon",
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelMedium
                      ?.copyWith(color: context.colorScheme.surface),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
