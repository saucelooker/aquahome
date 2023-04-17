import 'dart:async';
import 'package:aquahome_app/controls/sliders/slider_shapes.dart';
import 'package:aquahome_app/dependency_initializer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../base/general_data.dart';
import '../../style/theme_colors.dart';

class TemperatureSlider extends StatefulWidget {
  final void Function()? onChangeValue;
  final ColorMode mode;
  final ColorPickerElement currentValue;


  const TemperatureSlider(
      {Key? key,
      required this.currentValue,
      this.onChangeValue,
      this.mode = ColorMode.gradient})
      : super(key: key);

  @override
  State<TemperatureSlider> createState() => _TemperatureSliderState();
}

class _TemperatureSliderState extends State<TemperatureSlider> {
  late LinearGradient currentGradient;
  bool access = false;

  LinearGradient gradientListWithStops(ThemeColors colors) {
    final List<double> stopsList = [0.0];
    if (widget.mode == ColorMode.temperature) {
      for (var i = 1; i < 3; i++) {
        stopsList.add(1 / 2 * i);
      }
      currentGradient = LinearGradient(colors: [
        colors.blueColor,
        colors.midColor,
        colors.yellowColor
      ], stops: stopsList);
    } else {
      for (var i = 1; i < 12; i++) {
        stopsList.add(1 / 11 * i);
      }
      currentGradient = LinearGradient(colors: const [
        Color.fromARGB(255, 255, 102, 102),
        Color.fromARGB(255, 255, 179, 102),
        Color.fromARGB(255, 255, 255, 128),
        Color.fromARGB(255, 179, 255, 102),
        Color.fromARGB(255, 128, 255, 102),
        Color.fromARGB(255, 102, 255, 179),
        Color.fromARGB(255, 102, 255, 255),
        Color.fromARGB(255, 102, 179, 255),
        Color.fromARGB(255, 128, 128, 255),
        Color.fromARGB(255, 179, 102, 255),
        Color.fromARGB(255, 255, 102, 255),
        Color.fromARGB(255, 255, 102, 179),
      ], stops: stopsList);
    }
    return currentGradient;
  }

  Color lerpGradient(double t) {
    for (var s = 0; s < currentGradient.stops!.length - 1; s++) {
      final leftStop = currentGradient.stops![s],
          rightStop = currentGradient.stops![s + 1];
      final leftColor = currentGradient.colors[s],
          rightColor = currentGradient.colors[s + 1];
      if (t <= leftStop) {
        return leftColor;
      } else if (t < rightStop) {
        final sectionT = (t - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT) ??
            currentGradient.colors.last;
      }
    }
    return currentGradient.colors.last;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(4),
      height: 58,
      decoration: BoxDecoration(
          color: themeColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: themeColors.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(9)),
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.always,
            trackShape: RectTrackMarkShape(gradient: gradientListWithStops(themeColors)),
            overlayColor: Colors.transparent,
            thumbShape: RectThumbShape(
                thumbRadius: 7, color: themeColors.primaryBackgroundColor),
            valueIndicatorShape: RectValueIndicatorShape(
                color: widget.currentValue.color, show: access),
            tickMarkShape: const RectTickMarkShape(
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent),
          ),
          child: Slider.adaptive(
            label: '',
            value: widget.currentValue.value,
            onChangeStart: (_) {
              access = false;
            },
            onChangeEnd: (newValue) {
              if (widget.onChangeValue != null) {
                widget.onChangeValue!();
              }
              setState(() => access = false);
            },
            onChanged: (double newValue) {
              if ((newValue - widget.currentValue.value).abs() < 7) {
                setState(() {
                  access = true;
                  final color = lerpGradient(newValue / 100);
                  widget.currentValue.color = color;
                  widget.currentValue.value = newValue;
                });
                // if (widget.onChangeValue != null) {
                //   widget.onChangeValue!();
                // }
              }
            },
            min: 0,
            max: 100,
          ),
        ),
      ),
    );
  }
}

enum ColorMode { gradient, temperature }

class ColorPickerElement {
  Color color = const Color(0xffFFFFFF);
  double value = 50;

  ColorPickerElement(this.color, this.value);
}
