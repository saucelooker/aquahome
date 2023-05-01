import 'dart:ui';

import 'package:aquahome_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../dependency_initializer.dart';
import '../../generated/l10n.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../confirm_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String? message;
  final String? okButton;
  final String? cancelButton;

  const ConfirmDialog(
      {Key? key, this.message, this.okButton, this.cancelButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    final navService = serviceLocator<NavigationService>();
    final localization = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
        decoration: BoxDecoration(
            color: themeColors.theme == ThemeMode.dark ? themeColors.primaryBackgroundColor : themeColors.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(message ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.3,
                      fontSize: 14,
                      color: themeColors.primaryTextColor,
                      fontFamily: textRegular)),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ConfirmButton(
                    onTap: () => navService.goBack(false),
                    text: cancelButton ?? localization.cancel,
                    isConfirmButton: false,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ConfirmButton(
                      onTap: () => navService.goBack(true),
                      text: okButton ?? 'Ok',
                      textColor: themeColors.primaryTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
