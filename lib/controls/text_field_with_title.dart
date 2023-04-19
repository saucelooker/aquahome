import 'package:flutter/material.dart';

import '../style/fonts.dart';
import '../style/theme_colors.dart';

class TextFieldWithTitle extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final String? initValue;
  final Function(String)? onChange;
  final int? maxCharacters;

  const TextFieldWithTitle(
      {Key? key,
      this.title,
      this.placeholder,
      this.initValue,
      this.onChange,
      this.maxCharacters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title ?? '',
            style: TextStyle(
                fontFamily: displayLight,
                color: themeColors.secondaryTextColor,
                fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          initialValue: initValue,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
          autocorrect: false,
          cursorColor: themeColors.primaryTextColor,
          cursorWidth: 2,
          maxLength: maxCharacters,
          maxLines: null,
          style: TextStyle(
              color: themeColors.primaryTextColor,
              fontFamily: textLight,
              fontSize: 18),
          decoration: InputDecoration(
              isDense: true,
              counterText: '',
              fillColor: themeColors.secondaryBackgroundColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: themeColors.secondaryBackgroundColor),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: themeColors.secondaryBackgroundColor),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              hintText: placeholder,
              hintStyle: TextStyle(color: themeColors.secondaryTextColor)),
        ),
      ],
    );
  }
}
