import 'package:aquahome_app/base/ref_type_wrapper.dart';
import 'package:aquahome_app/main_page/model/light_control_model.dart';
import 'package:flutter/material.dart';
import '../../controls/rect_button.dart';
import '../../controls/sliders/intensity_slider.dart';
import '../../controls/sliders/gradient_slider.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';

class LightControlItem extends StatefulWidget {
  final LightControlModel model;
  final void Function(LightControlModel) onLightControl;
  final void Function() onDetail;
  final void Function() onIntensity;
  final void Function() onColor;

  const LightControlItem(
      {Key? key,
      required this.model,
      required this.onLightControl,
      required this.onDetail,
      required this.onIntensity,
      required this.onColor})
      : super(key: key);

  @override
  State<LightControlItem> createState() => _LightControlItemState();
}

class _LightControlItemState extends State<LightControlItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 12),
      child: GestureDetector(
        onTap: () => widget.onDetail(),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themeColors.secondaryBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RectButton(
                          onTap: () => widget.onLightControl(widget.model),
                          isOn: widget.model.isOn,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 58,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(right: 8, left: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.model.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: textLight,
                                      fontSize: 18,
                                      color: themeColors.primaryTextColor),
                                ),
                                Visibility(
                                  visible: widget.model.subtitle.isNotEmpty,
                                  child: Text(
                                    widget.model.subtitle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: textLight,
                                        fontSize: 11,
                                        color: themeColors.secondaryTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TemperatureSlider(
                        currentValue: widget.model.color,
                        onChangeValue: () => widget.onColor(),
                        mode: widget.model.mode)
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              RotatedBox(
                  quarterTurns: -1,
                  child: IntensitySlider(
                      currentValue: widget.model.intensity, onIntensity: widget.onIntensity)),
            ],
          ),
        ),
      ),
    );
  }
}
