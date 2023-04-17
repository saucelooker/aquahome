import 'dart:ui';

import 'package:aquahome_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../dependency_initializer.dart';
import '../style/fonts.dart';
import '../style/theme_colors.dart';
import 'confirm_button.dart';

class RangeTimeDialog extends StatefulWidget {
  final String? message;
  final String? okButton;
  final String? cancelButton;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  const RangeTimeDialog(
      {Key? key,
      this.message,
      this.okButton,
      this.cancelButton,
      this.startTime,
      this.endTime})
      : super(key: key);

  @override
  State<RangeTimeDialog> createState() => _RangeTimeDialogState();
}

class _RangeTimeDialogState extends State<RangeTimeDialog> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime ?? const TimeOfDay(hour: 0, minute: 0);
    _endTime = widget.endTime ?? const TimeOfDay(hour: 6, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    final navService = serviceLocator<NavigationService>();

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 6),
      decoration: BoxDecoration(
          color: themeColors.theme == ThemeMode.dark ? themeColors.primaryBackgroundColor : themeColors.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Время\nвключения\n\n',
                      style: TextStyle(
                          height: 0.8,
                          fontSize: 12,
                          fontFamily: textLight,
                          color: themeColors.secondaryTextColor),
                    ),
                    TextSpan(
                      text: DateFormat('HH:mm').format(DateTime(
                          0, 0, 0, _startTime.hour, _startTime.minute)),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: textMedium,
                          color: themeColors.primaryTextColor),
                    )
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Время\nвыключения\n\n',
                      style: TextStyle(
                          height: 0.8,
                          fontSize: 12,
                          fontFamily: textLight,
                          color: themeColors.secondaryTextColor),
                    ),
                    TextSpan(
                      text: DateFormat('HH:mm').format(
                          DateTime(0, 0, 0, _endTime.hour, _endTime.minute)),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: textMedium,
                          color: themeColors.primaryTextColor),
                    )
                  ]),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          TimeRangePicker(
            hideButtons: true,
            start: _startTime,
            end: _endTime,
            minDuration: const Duration(minutes: 5),
            clockRotation: 180,
            strokeWidth: 8,
            handlerRadius: 8,
            onStartChange: (start) => setState(() => _startTime = start),
            onEndChange: (end) => setState(() => _endTime = end),
            hideTimes: true,
            //padding: 48,
            labels: ["0", "3", "6", "9", "12", "15", "18", "21"]
                .asMap()
                .entries
                .map((e) {
              return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
            }).toList(),
            strokeColor: themeColors.primaryTextColor,
            handlerColor: themeColors.primaryTextColor,
            backgroundColor: themeColors.theme == ThemeMode.dark ? themeColors.secondaryBackgroundColor : themeColors.primaryBackgroundColor,
            selectedColor: themeColors.primaryTextColor,
            ticksWidth: 2,
            ticksLength: 20,
            // ticks: 36,
            ticksColor: themeColors.secondaryBackgroundColor,
            ticksOffset: -4,
            labelStyle: TextStyle(
                fontFamily: textLight,
                color: themeColors.secondaryTextColor,
                fontSize: 12),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: ConfirmButton(
                  onTap: () => navService.goBack(null),
                  text: widget.cancelButton ?? 'Отмена',
                  isConfirmButton: false,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ConfirmButton(
                    onTap: () => navService.goBack([_startTime, _endTime]),
                    text: widget.okButton ?? 'Ok',
                    textColor: themeColors.primaryTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
