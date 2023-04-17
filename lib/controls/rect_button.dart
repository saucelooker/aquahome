import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../style/constants.dart';
import '../style/theme_colors.dart';

class RectButton extends StatefulWidget {
  final String iconSource;
  final void Function()? onTap;
  final bool switchButton;
  final bool isOn;
  final Alignment alignment;
  final Color? baseColor;
  final Color? buttonColor;
  final Color? iconColor;

  const RectButton(
      {Key? key,
      this.onTap,
      this.switchButton = true,
      this.iconSource = 'assets/icons/delete_icon.png',
      this.isOn = false,
      this.alignment = Alignment.centerLeft,
      this.baseColor,
      this.buttonColor,
      this.iconColor})
      : super(key: key);

  @override
  State<RectButton> createState() => _RectButtonState();
}

class _RectButtonState extends State<RectButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Align(
      alignment: widget.alignment,
      child: Container(
          height: 58,
          width: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.baseColor ?? themeColors.primaryBackgroundColor,
          ),
          child: ZoomTapAnimation(
            end: 0.95,
            beginDuration: const Duration(milliseconds: pushAnimationTime),
            onLongTap: widget.switchButton
                ? () {
                    widget.onTap!();
                    HapticFeedback.lightImpact();
                    setState(() {});
                  }
                : null,
            onTap: !widget.switchButton
                ? () {
                    widget.onTap!();
                    HapticFeedback.lightImpact();
                  }
                : null,
            child: widget.switchButton
                ? Container(
                    padding: const EdgeInsets.all(4),
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: widget.buttonColor ??
                            themeColors.secondaryBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9))),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: fadeAnimationTime),
                      child: Image.asset(
                        key: Key(widget.isOn.toString()),
                        widget.isOn
                            ? 'assets/icons/light_on_icon.png'
                            : 'assets/icons/light_off_icon.png',
                        height: 27,
                        color: widget.isOn
                            ? widget.iconColor?? themeColors.primaryTextColor
                            : widget.iconColor?? themeColors.primaryTextColor.withOpacity(0.5),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(4),
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: widget.buttonColor ??
                            themeColors.secondaryBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9))),
                    child: Image.asset(
                      widget.iconSource,
                      height: 25,
                      color: widget.iconColor?? themeColors.primaryTextColor,
                    ),
                  ),
          )),
    );
  }
}
