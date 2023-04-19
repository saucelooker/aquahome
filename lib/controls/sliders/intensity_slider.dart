import 'dart:async';
import 'package:aquahome_app/base/ref_type_wrapper.dart';
import 'package:aquahome_app/controls/sliders/slider_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../style/theme_colors.dart';

class IntensitySlider extends StatefulWidget {
  final void Function()? onIntensity;
  final RefTypeWrapper currentValue;
  final bool longPressEnable;

  const IntensitySlider(
      {Key? key,
      required this.currentValue,
      this.onIntensity,
      this.longPressEnable = false})
      : super(key: key);

  @override
  State<IntensitySlider> createState() => _IntensitySliderState();
}

class _IntensitySliderState extends State<IntensitySlider> {
  bool access = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(2),
      height: 58,
      decoration: BoxDecoration(
          color: themeColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12)),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: RectTrackMarkShape(
              activeColor: themeColors.secondaryBackgroundColor),
          showValueIndicator: ShowValueIndicator.never,
          overlayColor: Colors.transparent,
          thumbShape: RectThumbShape(color: themeColors.primaryBackgroundColor),
          thumbColor: themeColors.secondaryTextColor,
          tickMarkShape: RectTickMarkShape(
              activeColor: themeColors.primaryBackgroundColor,
              inactiveColor: themeColors.secondaryBackgroundColor),
        ),
        child: Slider(
          value: widget.currentValue.value,
          onChanged: (double newValue) {
            if ((newValue - widget.currentValue.value).abs() <= 250 / 4 &&
                newValue != widget.currentValue.value) {
              setState(() {
                widget.currentValue.value = newValue;
              });
            }
          },
          onChangeStart: (_) {
            access = false;
          },
          onChangeEnd: (newValue) {
            access = false;
            if (widget.onIntensity != null) {
              widget.onIntensity!();
            }
          },
          min: 50,
          max: 250,
          divisions: 4,
        ),
      ),
    );
  }
}
