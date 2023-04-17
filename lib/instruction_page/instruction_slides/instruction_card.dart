import 'package:aquahome_app/controls/loading_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controls/confirm_button.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';

class InstructionCard {
  Widget setCard(BuildContext context, String title, String image,
      double imageWidth, String subtitle,
      {String key = '',
      String? confirmButtonName,
      String? cancelButtonName,
      void Function()? onConfirm,
      void Function()? onCancel,
      String Function(String)? onPassword,
      bool loading = false}) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Padding(
      key: Key(key),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        height: 474,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 24),
        decoration: BoxDecoration(
            color: themeColors.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 15,
              child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.3,
                        fontSize: 14,
                        color: themeColors.primaryTextColor,
                        fontFamily: textRegular)),
              ),
            ),
            Expanded(
                flex: 60,
                child: Center(
                    child: loading
                        ? Stack(alignment: Alignment.center, children: [
                            Image.asset(image,
                                isAntiAlias: true, width: imageWidth, color: themeColors.primaryTextColor),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoadingPoints(
                                    child: Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: themeColors.primaryTextColor,
                                      borderRadius: BorderRadius.circular(2)),
                                )),
                                const SizedBox(width: 9),
                                LoadingPoints(
                                    delay: 100,
                                    child: Container(
                                      height: 4,
                                      width: 4,
                                      decoration: BoxDecoration(
                                          color: themeColors.primaryTextColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    )),
                                const SizedBox(width: 9),
                                LoadingPoints(
                                    delay: 200,
                                    child: Container(
                                      height: 4,
                                      width: 4,
                                      decoration: BoxDecoration(
                                          color: themeColors.primaryTextColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    )),
                              ],
                            ),
                            Transform.translate(
                                offset: const Offset(-78, 0),
                                child: SizedBox(
                                    height: 17,
                                    width: 17,
                                    child: TweenAnimationBuilder<double>(
                                      curve: Curves.easeInOutSine,
                                      tween: Tween<double>(begin: 0.0, end: 1),
                                      duration: const Duration(seconds: 30),
                                      builder: (context, value, _) =>
                                          CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 2,
                                        color: themeColors.primaryTextColor,
                                      ),
                                    )))
                          ])
                        : Image.asset(image,
                            isAntiAlias: true, width: imageWidth, color: themeColors.primaryTextColor))),
            Expanded(
              flex: 25,
              child: Center(
                child: onPassword != null
                    ? TextField(
                        onChanged: (value) {
                          onPassword(value);
                        },
                        autocorrect: false,
                        cursorColor: themeColors.primaryTextColor,
                        cursorHeight: 17,
                        cursorWidth: 1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: displayLight,
                            fontSize: 14),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: themeColors.primaryBackgroundColor,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: themeColors.primaryBackgroundColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: themeColors.primaryBackgroundColor)),
                            hintText: 'Введите пароль',
                            hintStyle: TextStyle(
                                color: themeColors.secondaryTextColor,
                                fontFamily: textLight,
                                fontSize: 12)),
                      )
                    : Text(subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: themeColors.secondaryTextColor,
                            fontFamily: textLight)),
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  onCancel == null || cancelButtonName == null
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: ConfirmButton(
                            onTap: () => onCancel(),
                            text: cancelButtonName,
                            isConfirmButton: false,
                          ),
                        ),
                  onConfirm == null || confirmButtonName == null
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: ConfirmButton(
                              onTap: () => onConfirm(),
                              text: confirmButtonName),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
