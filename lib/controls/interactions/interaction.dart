import 'dart:async';
import 'dart:ui';
import 'package:aquahome_app/style/constants.dart';
import 'package:aquahome_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../style/theme_colors.dart';

class Interaction {
  BuildContext context;
  late ThemeColors themeColors;
  final bool? dismissible;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final bool softAppearing;

  Interaction(this.context,
      {this.dismissible,
      this.padding,
      this.alignment,
      this.softAppearing = true}) {
    themeColors = Theme.of(context).extension<ThemeColors>()!;
  }

  late Timer _timer;

  Future<Object?>? dialog(Widget widget) async {
    return await showGeneralDialog(
      barrierDismissible: dismissible ?? true,
      barrierLabel: '',
      barrierColor: softAppearing ? Colors.black54 : Colors.transparent,
      transitionDuration:
          Duration(milliseconds: softAppearing ? fadeAnimationTime : 10),
      pageBuilder: (ctx, anim1, anim2) => widget,
      transitionBuilder: (ctx, anim1, anim2, child) => FadeTransition(
        opacity: CurvedAnimation(parent: anim1, curve: Curves.easeInOutCubic),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: padding ?? const EdgeInsets.all(50.0),
            child:
                Align(alignment: alignment ?? Alignment.center, child: widget),
          ),
        ),
      ),
      context: context,
    );
  }

  toast(String message,
      [Duration duration = const Duration(milliseconds: 2000),
      Widget? widget]) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(duration, () {
            Navigator.of(context).pop();
          });

          return widget ??
              AlertDialog(
                  insetPadding: const EdgeInsets.all(8),
                  titlePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: const Color(0xffFF6961),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: displayLight,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                  title: Text(message),
                  alignment: Alignment.topCenter,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)));
        }).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }
}
