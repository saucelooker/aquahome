import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../style/theme_colors.dart';

class ActionButton extends StatelessWidget {
  final Function() onTap;
  final dynamic icon;
  final Alignment alignment;
  final Size? iconSize;
  final Color? iconColor;

  const ActionButton(
      {Key? key,
      required this.onTap,
      this.icon,
      this.alignment = Alignment.center,
      this.iconSize,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return SizedBox(
      height: iconSize?.height ?? 28,
      child: ZoomTapAnimation(
        child: IconButton(
          alignment: alignment,
          padding: EdgeInsets.zero,
          onPressed: () => onTap(),
          icon: icon is String
              ? Image.asset(
                  icon,
                  height: iconSize?.height ?? 28,
                  width: iconSize?.width ?? 28,
                  color: iconColor?? themeColors.primaryTextColor,
                )
              : Icon(
                  icon,
                  size: iconSize?.height ?? 28,
                  color: iconColor?? themeColors.primaryTextColor,
                ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
    );
  }
}
