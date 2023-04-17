import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/controls/action_button.dart';
import 'package:aquahome_app/controls/confirm_button.dart';
import 'package:aquahome_app/main_page/view_models/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../cells/light_control_item.dart';


class MainPageView extends PageWidget<MainPageViewModel> {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context, MainPageViewModel viewModel,
      ThemeColors themeColors, S localizations) {
    return Consumer<MainPageViewModel>(
        builder: (context, viewModel, child) => viewModel
                .lightsCollection.isNotEmpty
            ? RefreshIndicator(
                color: Colors.black87,
                onRefresh: () => Future(() => null),
                child: ListView.builder(
                    // physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 4),
                    itemCount: viewModel.lightsCollection.length,
                    itemBuilder: (context, index) {
                      var item = viewModel.lightsCollection[index];
                      return LightControlItem(
                        model: item,
                        onLightControl: (model) => viewModel.sendMessage(model),
                        onDetail: () => viewModel.navigateToDetailPage(item),
                        onIntensity: () => viewModel.changeIntensity(item),
                        onColor: () => viewModel.changeColor(item),
                      );
                    }),
              )
            : Container(
                alignment: Alignment.center,
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizations.mainPageEmpty ,
                        style: TextStyle(
                            fontFamily: textLight,
                            fontSize: 16,
                            color: themeColors.primaryTextColor)),
                    const SizedBox(height: 4),
                    ConfirmButton(
                        onTap: () => viewModel.addModule(),
                        onLongTap: () => viewModel.addModule(longPress: true),
                        text: localizations.mainPageAdd)
                  ],
                ),
              ));
  }

  @override
  AppBarConfig appBarConfiguration(MainPageViewModel viewModel) {
    return AppBarConfig(title: 'AQUAHOME', actionList: [
      ActionButton(
        onTap: () => viewModel.showOptions(),
        icon: 'assets/icons/additionally_icon.png',
      ),
    ]);
  }
}
