import 'package:aquahome_app/style/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../style/theme_colors.dart';

class ConfirmButton extends StatefulWidget {
  final void Function() onTap;
  final String text;
  final bool isConfirmButton;
  final Color? textColor;
  final double? fontSize;

  const ConfirmButton(
      {Key? key,
      required this.onTap,
      this.text = 'OK',
      this.isConfirmButton = true,
      this.textColor,
      this.fontSize})
      : super(key: key);

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return
      ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 40),
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Text(
          widget.text,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
              fontSize: widget.fontSize ?? (widget.isConfirmButton ? 14 : 12),
              fontFamily: widget.isConfirmButton ? textRegular : textLight,
              color: widget.textColor ??
                  (widget.isConfirmButton
                      ? themeColors.primaryTextColor
                      : themeColors.secondaryTextColor)),
        ),
      ),
    );
  }
}
