import 'package:flutter/material.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors(
      {this.primaryTextColor = const Color(0xffF6F6F6),
      this.secondaryTextColor = const Color(0xff808080),
      this.thirdTextColor = const Color(0xff808080),
      this.backgroundColor = const Color(0xff111111),
      this.primaryBackgroundColor = const Color(0xff2D2D2D),
      this.secondaryBackgroundColor = const Color(0xff1D1D1D),
      this.notActiveColor = const Color(0xffAAAAAA),
      this.corralColor = const Color(0xffD65E5E),
      this.yellowColor = const Color(0xffFFDD99),
      this.midColor = const Color(0xffE7E7E7),
      this.blueColor = const Color(0xff9ADDFE),});

  ThemeMode get theme => primaryTextColor == const Color(0xffFFFFFF) ? ThemeMode.dark : ThemeMode.light;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color thirdTextColor;
  final Color backgroundColor;
  final Color primaryBackgroundColor;
  final Color secondaryBackgroundColor;
  final Color notActiveColor;
  final Color corralColor;
  final Color yellowColor;
  final Color midColor;
  final Color blueColor;

  @override
  ThemeColors copyWith(
      {Color? primaryTextColor,
      Color? secondaryTextColor,
      Color? thirdTextColor,
      Color? backgroundColor,
      Color? primaryBackgroundColor,
      Color? secondaryBackgroundColor,
      Color? notActiveColor,
      Color? corralColor,
      Color? yellowColor,
      Color? midColor,
      Color? blueColor}) {
    return ThemeColors(
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
        thirdTextColor: thirdTextColor?? this.thirdTextColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        primaryBackgroundColor:
            primaryBackgroundColor ?? this.primaryBackgroundColor,
        secondaryBackgroundColor:
            secondaryBackgroundColor ?? this.secondaryBackgroundColor,
        notActiveColor: notActiveColor ?? this.notActiveColor,
        corralColor: corralColor ?? this.corralColor,
        yellowColor: yellowColor ?? this.yellowColor,
        midColor: midColor ?? this.midColor,
        blueColor: blueColor ?? this.blueColor);
  }

  @override
  ThemeColors lerp(ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      primaryTextColor:
          Color.lerp(primaryTextColor, other.primaryTextColor, t) ??
              const Color(0xffF6F6F6),
      secondaryTextColor:
          Color.lerp(secondaryTextColor, other.secondaryTextColor, t) ??
              const Color(0xff808080),
      thirdTextColor:
      Color.lerp(thirdTextColor, other.thirdTextColor, t) ??
          const Color(0xff808080),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          const Color(0xff111111),
      primaryBackgroundColor:
          Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t) ??
              const Color(0xff2D2D2D),
      secondaryBackgroundColor: Color.lerp(
              secondaryBackgroundColor, other.secondaryBackgroundColor, t) ??
          const Color(0xff1D1D1D),
      notActiveColor: Color.lerp(notActiveColor, other.notActiveColor, t) ??
          const Color(0xffAAAAAA),
      corralColor: Color.lerp(corralColor, other.corralColor, t) ??
          const Color(0xffD65E5E),
      yellowColor:
          Color.lerp(yellowColor, other.yellowColor, t) ??
              const Color(0xffFFDD99),
      midColor: Color.lerp(midColor, other.midColor, t) ??
          const Color(0xffE7E7E7),
      blueColor: Color.lerp(blueColor, other.blueColor, t) ??
          const Color(0xffFFDD99),
    );
  }
}

var lightTheme = ThemeColors(
    primaryTextColor: const Color(0xff1D1D1D),
    secondaryTextColor: const Color(0xff1D1D1D).withOpacity(0.3),
    thirdTextColor: const Color(0xff1D1D1D).withOpacity(0.7),
    backgroundColor: const Color(0xffF5F5F5),
    primaryBackgroundColor: const Color(0xffD3D3D3),
    secondaryBackgroundColor: const Color(0xffFFFFFF),
    notActiveColor: const Color(0xffAAAAAA),
    corralColor: const Color(0xffD65E5E),
    yellowColor: const Color(0xffFFB866),
    midColor: const Color(0xffF5F5F5),
    blueColor: const Color(0xff80D4FF));

var darkTheme = const ThemeColors(
    primaryTextColor: Color(0xffFFFFFF),
    secondaryTextColor: Color(0xff808080),
    thirdTextColor: Color(0xff2D2D2D),
    backgroundColor: Color(0xff111111),
    primaryBackgroundColor: Color(0xff2D2D2D),
    secondaryBackgroundColor: Color(0xff1D1D1D),
    notActiveColor: Color(0xffAAAAAA),
    corralColor: Color(0xffD65E5E),
    yellowColor: Color(0xffFFB366),
    midColor: Color(0xffE7E7E7),
    blueColor: Color(0xff66B3D7));
