import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/base/ref_type_wrapper.dart';
import 'package:aquahome_app/controls/rect_button.dart';
import 'package:aquahome_app/controls/sliders/gradient_slider.dart';
import 'package:aquahome_app/controls/sliders/intensity_slider.dart';
import 'package:aquahome_app/datail_page/cells/work_period_cell.dart';
import 'package:aquahome_app/datail_page/view_models/detail_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../controls/action_button.dart';
import '../../controls/text_field_with_title.dart';
import '../../style/constants.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';

class DetailPageView extends PageWidget<DetailPageViewModel> {
  DetailPageView({super.key}) : super();
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context, DetailPageViewModel viewModel,
      ThemeColors themeColors) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWithTitle(
                  title: 'Название',
                  placeholder: 'Введите название',
                  initValue: viewModel.model.title,
                  onChange: (value) => viewModel.title = value),
              const SizedBox(
                height: 16,
              ),
              TextFieldWithTitle(
                  title: 'Краткое описание',
                  placeholder: 'Заполните описание',
                  initValue: viewModel.model.subtitle,
                  onChange: (value) => viewModel.description = value),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Режим',
                  style: TextStyle(
                      fontFamily: displayLight,
                      color: themeColors.secondaryTextColor,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              DefaultTabController(
                animationDuration: const Duration(milliseconds: 300),
                initialIndex: viewModel.colorMode == ColorMode.gradient ? 0 : 1,
                length: 2,
                child: Column(
                  children: [
                    Container(
                        height: 38,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeColors.primaryBackgroundColor,
                        ),
                        child: TabBar(
                          onTap: (tab) => viewModel.colorMode = tab == 0
                              ? ColorMode.gradient
                              : ColorMode.temperature,
                          splashBorderRadius: BorderRadius.circular(9),
                          splashFactory: InkSparkle.splashFactory,
                          enableFeedback: true,
                          indicatorWeight: 0,
                          indicator: BoxDecoration(
                              color: themeColors.secondaryBackgroundColor,
                              borderRadius: BorderRadius.circular(9)),
                          labelColor: themeColors.primaryTextColor,
                          labelStyle: TextStyle(
                              color: themeColors.primaryTextColor,
                              fontFamily: textLight,
                              fontSize: 14),
                          unselectedLabelColor: themeColors.secondaryTextColor,
                          unselectedLabelStyle: TextStyle(
                              color: themeColors.secondaryTextColor,
                              fontFamily: textLight,
                              fontSize: 14),
                          tabs: const [Text('Градиент'), Text('Температура')],
                        )),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 58,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TemperatureSlider(
                                currentValue: viewModel.colorValue,
                                onChangeValue: () {},
                                mode: ColorMode.gradient),
                            TemperatureSlider(
                                currentValue: viewModel.colorValue,
                                onChangeValue: () {},
                                mode: ColorMode.temperature),
                          ]),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Яркость',
                  style: TextStyle(
                      fontFamily: displayLight,
                      color: themeColors.secondaryTextColor,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              IntensitySlider(currentValue: viewModel.intensity),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Рассписание',
                      style: TextStyle(
                          fontFamily: displayLight,
                          color: themeColors.secondaryTextColor,
                          fontSize: 14),
                    ),
                    ActionButton(
                        onTap: () async {
                          var result = await viewModel.addWorkTime();
                          if (result) {
                            _key.currentState!.insertItem(0,
                                duration: const Duration(
                                    milliseconds: fadeAnimationTime));
                          }
                        },
                        icon: 'assets/icons/add_icon_alt.png',
                        alignment: Alignment.centerRight,
                        iconColor: themeColors.primaryTextColor),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Consumer<DetailPageViewModel>(
                builder: (context, viewModel, child) =>
                    SlidableAutoCloseBehavior(
                  closeWhenOpened: true,
                  child: AnimatedList(
                      key: _key,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      initialItemCount: viewModel.schedule.length,
                      itemBuilder: (context, index, animation) {
                        final item = viewModel.schedule[index];
                        return SizeTransition(
                            key: Key(item.id),
                            sizeFactor: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOutCubic),
                            child: FadeTransition(
                                key: Key(item.id),
                                opacity: Tween<double>(begin: 0, end: 1)
                                    .animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOutCubic)),
                                child: WorkPeriodCell(
                                    model: item,
                                    onDelete: (controller) async {
                                      var result =
                                          await viewModel.deleteWorkTime(item);
                                      if (result) {
                                        await controller?.close(
                                            duration: const Duration(
                                                milliseconds: 150),
                                            curve: Curves.easeInOutCubic);
                                        _key.currentState!.removeItem(
                                            index,
                                            (context, animation) =>
                                                FadeTransition(
                                                    key: Key(item.id),
                                                    opacity: Tween<double>(
                                                            begin: 0, end: 1)
                                                        .animate(CurvedAnimation(
                                                            parent: animation,
                                                            curve: Curves
                                                                .easeInOutCubic)),
                                                    child: SizeTransition(
                                                      key: Key(item.id),
                                                      sizeFactor: CurvedAnimation(
                                                          parent: animation,
                                                          curve: Curves
                                                              .easeInOutCubic),
                                                      child: WorkPeriodCell(
                                                        model: item,
                                                      ),
                                                    )),
                                            duration: const Duration(
                                                milliseconds:
                                                    fadeAnimationTime));
                                      }
                                    },
                                    onChangeTime: () =>
                                        viewModel.changeWorkTime(item))));
                      }),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ZoomTapAnimation(
                beginDuration: const Duration(milliseconds: 40),
                onTap: () => viewModel.save(),
                child: Container(
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeColors.theme == ThemeMode.dark
                        ? themeColors.secondaryBackgroundColor
                        : themeColors.primaryBackgroundColor,
                  ),
                  child: Text('Сохранить',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: textRegular,
                          color: themeColors.primaryTextColor)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ZoomTapAnimation(
                beginDuration: const Duration(milliseconds: 40),
                onTap: () => viewModel.deleteItem(),
                child: Container(
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeColors.secondaryBackgroundColor,
                  ),
                  child: Text('Удалить модуль',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: textRegular,
                          color: themeColors.corralColor)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }

  @override
  AppBarConfig appBarConfiguration(DetailPageViewModel viewModel) =>
      AppBarConfig(title: viewModel.model.title, showBackButton: true);
}
