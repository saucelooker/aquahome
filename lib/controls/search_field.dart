import 'dart:async';
import 'dart:io';

import 'package:aquahome_app/style/fonts.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../style/theme_colors.dart';

class SearchField extends StatelessWidget {
  final String? placeholder;
  final Function(String)? onChange;
  final Function? onTap;

  const SearchField(
      {Key? key, this.placeholder, this.onTap, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    final localization = S.of(context);
    return SizedBox(
      height: 38,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) {
          if (onChange != null) {
            waiting(() => onChange!(value));
          }
        },
        autocorrect: false,
        cursorColor: themeColors.primaryTextColor,
        cursorWidth: 2,
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
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.secondaryBackgroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.secondaryBackgroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            prefixIcon: Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              child: Image.asset(
                'assets/icons/search_icon.png',
                height: 20,
                color: themeColors.secondaryTextColor,
              ),
            ),
            hintText: placeholder?? localization.search,
            hintStyle: TextStyle(color: themeColors.secondaryTextColor)),
      ),
    );
  }
}

Timer? _timer;

waiting(VoidCallback action, [int duration = 800]) {
  if (_timer != null) {
    _timer!.cancel();
  }
  _timer = Timer(Duration(milliseconds: duration), action);
}
