import 'package:aquahome_app/main_page/model/work_period_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../controls/rect_button.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';

class WorkPeriodCell extends StatefulWidget {
  final WorkPeriodModel model;
  final Function(SlidableController?)? onDelete;
  final void Function()? onChangeTime;

  const WorkPeriodCell(
      {Key? key, required this.model, this.onDelete, this.onChangeTime})
      : super(key: key);

  @override
  State<WorkPeriodCell> createState() => _WorkPeriodCellState();
}

class _WorkPeriodCellState extends State<WorkPeriodCell>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(milliseconds: 250),
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
    final themeColors = Theme.of(context).extension<ThemeColors>()!;
    _animationController.value = widget.model.enable ? 1 : 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        key: Key(widget.model.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 66 / (MediaQuery.of(context).size.width - 16),
          children: [
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RectButton(
                    onTap: () async {
                      if (widget.onDelete != null) {
                        widget.onDelete!(Slidable.of(context));
                      }
                    },
                    alignment: Alignment.center,
                    switchButton: false,
                    baseColor: themeColors.secondaryBackgroundColor,
                    buttonColor: themeColors.secondaryBackgroundColor,
                    iconColor: themeColors.corralColor),
              );
            }),
          ],
        ),
        child: Container(
          height: 58,
          padding: const EdgeInsets.only(left: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: themeColors.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(16)),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => Row(
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    if (widget.onChangeTime != null) {
                      widget.onChangeTime!();
                    }
                  },
                  end: 0.98,
                  child: AnimatedSwitcher(
                    layoutBuilder: (currentChild, previousChild) {
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          ...previousChild,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      key: ValueKey<String>(
                          '${DateFormat('HH:mm').format(widget.model.start)} - ${DateFormat('HH:mm').format(widget.model.end)}'),
                      child: Text(
                        '${DateFormat('HH:mm').format(widget.model.start)} - ${DateFormat('HH:mm').format(widget.model.end)}',
                        key: ValueKey<bool>(widget.model.enable),
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: textLight,
                            color: Color.lerp(
                                themeColors.primaryBackgroundColor,
                                themeColors.theme == ThemeMode.dark
                                    ? themeColors.primaryTextColor
                                    : themeColors.thirdTextColor,
                                _animationController.value)!,
                            fontSize: 34),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child:
                        Switch(
                          value: widget.model.enable,
                          onChanged: (val) {
                            if (val) {
                              _animationController.animateTo(1,
                                  curve: Curves.easeInOutCubic);
                              widget.model.enable = true;
                            } else {
                              _animationController.animateTo(0,
                                  curve: Curves.easeInOutCubic);
                              widget.model.enable = false;
                            }
                          },
                          inactiveThumbColor:
                              themeColors.primaryBackgroundColor,
                          splashRadius: 0,
                          activeColor: themeColors.theme == ThemeMode.dark
                              ? themeColors.primaryTextColor
                              : themeColors.thirdTextColor,
                        )
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
