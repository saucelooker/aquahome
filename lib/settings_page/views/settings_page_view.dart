import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/controls/text_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../generated/l10n.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../view_models/settings_page_view_model.dart';

class SettingsPageView extends PageWidget<SettingsPageViewModel> {
  const SettingsPageView({super.key});

  @override
  AppBarConfig appBarConfiguration(SettingsPageViewModel viewModel) {
    return AppBarConfig(title: viewModel.locale.settingsPageTitle, showBackButton: true);
  }

  int initLanguage(String language) {
    return language == 'ru' ? 0 : 1;
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
  Widget buildWrapper(BuildContext context, SettingsPageViewModel viewModel,
      ThemeColors themeColors, S localizations) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWithTitle(
                  title: localizations.settingsPagePasswordTitle,
                  placeholder: localizations.settingsPagePasswordPlaceholder,
                  initValue: viewModel.password,
                  onChange: (value) => viewModel.password = value),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  localizations.settingsPageThemeTitle,
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
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeColors.primaryBackgroundColor,
                        ),
                        child: TabBar(
                          onTap: (tab) => viewModel.setTheme(tab),
                          splashBorderRadius: BorderRadius.circular(10),
                          splashFactory: InkSparkle.splashFactory,
                          enableFeedback: true,
                          indicatorWeight: 0,
                          indicator: BoxDecoration(
                              color: themeColors.secondaryBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
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
                          tabs: [
                            Text(localizations.settingsPageLightTheme),
                            Text(localizations.settingsPageDarkTheme),
                            Text(localizations.settingsPageSystemTheme)
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  localizations.settingsPageLanguageTitle,
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
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeColors.primaryBackgroundColor,
                        ),
                        child: TabBar(
                          onTap: (tab) => viewModel.setLanguage(tab),
                          splashBorderRadius: BorderRadius.circular(10),
                          splashFactory: InkSparkle.splashFactory,
                          enableFeedback: true,
                          indicatorWeight: 0,
                          indicator: BoxDecoration(
                              color: themeColors.secondaryBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
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
                          tabs: [Text(localizations.settingsPageRussianLanguage), Text(localizations.settingsPageEnglishLanguage)],
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
                  child: Text(localizations.save,
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
