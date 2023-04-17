import 'package:aquahome_app/controls/sliders/slider_shapes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../base/ref_type_wrapper.dart';
import '../style/theme_colors.dart';

class TimeToggle extends StatefulWidget {
  final void Function(bool)? onSwitch;
  final RefTypeWrapper currentValue;
  final Alignment alignment;

  const TimeToggle(
      {Key? key,
      required this.currentValue,
      this.onSwitch,
      this.alignment = Alignment.centerRight})
      : super(key: key);

  @override
  State<TimeToggle> createState() => _TimeToggleState();
}

class _TimeToggleState extends State<TimeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    _animationController.value = widget.currentValue.value;
    return
      Align(
      alignment: widget.alignment,
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          height: 58,
          width: 58,
          decoration: BoxDecoration(
              color: themeColors.primaryBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackShape: RectTrackMarkShape(
                    activeColor: themeColors.secondaryBackgroundColor,
                    inactiveColor: themeColors.secondaryBackgroundColor),
                showValueIndicator: ShowValueIndicator.never,
                overlayColor: Colors.transparent,
                thumbShape: RectThumbShape(
                    color: Color.lerp(
                        themeColors.primaryBackgroundColor,
                        themeColors.primaryTextColor,
                        _animationController.value)!),
                thumbColor: themeColors.secondaryTextColor,
                tickMarkShape: const RectTickMarkShape(),
              ),
              child: Slider.adaptive(
                value: _animationController.value,
                onChanged: (double newValue) {
                  // HapticFeedback.lightImpact();
                  _animationController.value = newValue;
                  widget.currentValue.value = newValue;
                },
                onChangeEnd: (double newValue) {
                  _animationController.forward(from: newValue);
                  if (newValue > 0.5) {
                    _animationController.animateTo(1);
                    if (widget.onSwitch != null) {
                      widget.onSwitch!(true);
                    }
                  } else {
                    if (widget.onSwitch != null) {
                      widget.onSwitch!(false);
                    }
                    _animationController.animateTo(0);
                  }
                },
                min: 0,
                max: 1,
                //divisions: 1,
              ),
            ),
          )),
    );
  }
}
