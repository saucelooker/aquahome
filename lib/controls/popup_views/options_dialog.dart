import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../dependency_initializer.dart';
import '../../services/navigation_service.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../confirm_button.dart';

class OptionsDialog extends StatefulWidget {
  final List<String> options;

  const OptionsDialog({Key? key, required this.options}) : super(key: key);

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog>
    with SingleTickerProviderStateMixin {
  bool resize = false;
  var widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Padding(
          padding: EdgeInsets.only(
            right: 32,
            top: 19 + MediaQuery.of(context).padding.top,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                key: widgetKey,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(2)),
                    color: themeColors.primaryTextColor),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: widget.options
                        .map((e) => Flexible(
                              child: ConfirmButton(
                                  onTap: () async {
                                    // await animationController.reverse();
                                    serviceLocator<NavigationService>()
                                        .goBack(e);
                                  },
                                  text: e,
                                  textColor: themeColors.backgroundColor,
                                  fontSize: 14),
                            ))
                        .toList())),
          )),
    );
  }
}

class ZoomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double fontSize;

  const ZoomButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Expanded(
      child: ZoomTapAnimation(
        beginDuration: const Duration(milliseconds: 40),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          color: Colors.transparent,
          child: Text(text,
              maxLines: 1,
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: textRegular,
                  color: themeColors.backgroundColor)),
        ),
      ),
    );
  }
}
