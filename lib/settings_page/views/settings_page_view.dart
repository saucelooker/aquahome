import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/base_page_view.dart';
import 'package:aquahome_app/controls/text_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../view_models/settings_page_view_model.dart';

class SettingsPageView extends BasePageView<SettingsPageViewModel> {
  const SettingsPageView({super.key});

  @override
  AppBarConfig appBarConfiguration(SettingsPageViewModel viewModel) {
    return AppBarConfig(title: 'Настройки', showBackButton: true);
  }

  int initLanguage(String language) {
    return language == 'RU' ? 0 : 1;
  }

  int initTheme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.dark:
        return 1;
      default:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context, SettingsPageViewModel viewModel,
      ThemeColors themeColors) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWithTitle(
                  title: 'Пароль Wi-fi',
                  placeholder: 'Введите пароль Wi-fi',
                  initValue: viewModel.password,
                  onChange: (value) => viewModel.password = value),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Тема',
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
                initialIndex: initTheme(viewModel.theme),
                length: 3,
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
                          onTap: (tab) => viewModel.setTheme(tab),
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
                          tabs: const [
                            Text('Светлая'),
                            Text('Темная'),
                            Text('Системная')
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Язык',
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
                initialIndex: initLanguage(viewModel.language),
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
                          onTap: (tab) => viewModel.setLanguage(tab),
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
                          tabs: const [Text('Русский'), Text('English')],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ZoomTapAnimation(
                beginDuration: const Duration(milliseconds: 40),
                onTap: () => viewModel.saveSetting(),
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
                height: 16,
              ),
            ],
          ),
        ));
  }
}
