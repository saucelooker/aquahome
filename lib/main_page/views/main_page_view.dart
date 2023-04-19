import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/controls/action_button.dart';
import 'package:aquahome_app/controls/confirm_button.dart';
import 'package:aquahome_app/controls/search_field.dart';
import 'package:aquahome_app/main_page/view_models/main_page_view_model.dart';
import 'package:aquahome_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../cells/light_control_item.dart';

class MainPageView extends PageWidget<MainPageViewModel> {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<PageWidget> createState() => _MainPageViewState();

  @override
  AppBarConfig appBarConfiguration(MainPageViewModel viewModel) {
    return AppBarConfig(
      title: 'AQUAHOME',
    );
  }
}

class _MainPageViewState extends PageWidgetState<MainPageViewModel>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;
  late Animation<double> transition;
  bool hubHidden = false;
  double position = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutSine));
    transition = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutSine));
    animationController.value = 0;
  }

  @override
  Widget buildWrapper(BuildContext context, MainPageViewModel viewModel,
      ThemeColors themeColors, S localizations) {
    return Stack(
      children: [
        Consumer<MainPageViewModel>(
            builder: (context, viewModel, child) => viewModel
                    .lightsCollection.isNotEmpty
                ? NotificationListener<ScrollUpdateNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels >= 54 && !hubHidden) {
                        hubHidden = true;
                        animationController.animateTo(1);
                      } else if (scrollInfo.metrics.pixels <= 54 && hubHidden) {
                        hubHidden = false;
                        animationController.animateTo(0);
                      }
                      return true;
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 4, top: 116),
                        itemCount: viewModel.lightsCollection.length,
                        itemBuilder: (context, index) {
                          var item = viewModel.lightsCollection[index];
                          return LightControlItem(
                            model: item,
                            onLightControl: (model) =>
                                viewModel.sendMessage(model),
                            onDetail: () =>
                                viewModel.navigateToDetailPage(item),
                            onIntensity: () => viewModel.changeIntensity(item),
                            onColor: () => viewModel.changeColor(item),
                          );
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 116),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(localizations.mainPageEmpty,
                              style: TextStyle(
                                  fontFamily: textLight,
                                  fontSize: 16,
                                  color: themeColors.primaryTextColor)),
                          const SizedBox(height: 4),
                          ConfirmButton(
                              onTap: () => viewModel.addModule(),
                              onLongTap: () =>
                                  viewModel.addModule(longPress: true),
                              text: localizations.mainPageAdd)
                        ],
                      ),
                    ),
                  )),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Container(
            height: 98 - transition.value * 54,
            decoration: BoxDecoration(
                color: themeColors.backgroundColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 32,
                      color: themeColors.secondaryTextColor.withOpacity(0.3))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: opacity,
                  child: Opacity(
                    opacity: opacity.value,
                    child: const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: SearchField()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButton(
                        onTap: () {},
                        icon: Icons.change_circle_rounded,
                        iconColor: themeColors.primaryTextColor.withOpacity(0.9)),
                    ActionButton(
                        onTap: () => viewModel.addModule(),
                        icon: Icons.add_circle,
                        iconColor: themeColors.primaryTextColor.withOpacity(0.9)),
                    ActionButton(
                        onTap: () => viewModel.navigationService
                            .navigationTo(settingPageRoute),
                        icon: Icons.settings_rounded,
                        iconColor: themeColors.primaryTextColor.withOpacity(0.9)),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// class MainPageView extends PageWidget<MainPageViewModel> {
//   const MainPageView({super.key});
//
//   @override
//   Widget build(BuildContext context, MainPageViewModel viewModel,
//       ThemeColors themeColors, S localizations) {
//     return Stack(
//       children: [
//         Consumer<MainPageViewModel>(
//             builder: (context, viewModel, child) => viewModel
//                     .lightsCollection.isNotEmpty
//                 ? ListView.builder(
//                     // physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.only(bottom: 4, top: 116),
//                     itemCount: viewModel.lightsCollection.length,
//                     itemBuilder: (context, index) {
//                       var item = viewModel.lightsCollection[index];
//                       return LightControlItem(
//                         model: item,
//                         onLightControl: (model) => viewModel.sendMessage(model),
//                         onDetail: () => viewModel.navigateToDetailPage(item),
//                         onIntensity: () => viewModel.changeIntensity(item),
//                         onColor: () => viewModel.changeColor(item),
//                       );
//                     })
//                 : Padding(
//                     padding: const EdgeInsets.only(top: 116),
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(localizations.mainPageEmpty,
//                               style: TextStyle(
//                                   fontFamily: textLight,
//                                   fontSize: 16,
//                                   color: themeColors.primaryTextColor)),
//                           const SizedBox(height: 4),
//                           ConfirmButton(
//                               onTap: () => viewModel.addModule(),
//                               onLongTap: () =>
//                                   viewModel.addModule(longPress: true),
//                               text: localizations.mainPageAdd)
//                         ],
//                       ),
//                     ),
//                   )),
//         Container(
//           height: 98,
//           decoration: BoxDecoration(
//               color: themeColors.backgroundColor,
//               borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(20),
//                   bottomLeft: Radius.circular(20)),
//               boxShadow: [
//                 BoxShadow(
//                     offset: const Offset(0, 0),
//                     blurRadius: 32,
//                     color: themeColors.secondaryTextColor.withOpacity(0.3))
//               ]),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: SearchField()),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ActionButton(
//                       onTap: () {},
//                       icon: Icons.change_circle_rounded,
//                       iconColor: themeColors.primaryTextColor),
//                   ActionButton(
//                       onTap: () => viewModel.addModule(),
//                       icon: Icons.add_circle,
//                       iconColor: themeColors.primaryTextColor),
//                   ActionButton(
//                       onTap: () => viewModel.navigationService
//                           .navigationTo(settingPageRoute),
//                       icon: Icons.settings_rounded,
//                       iconColor: themeColors.primaryTextColor),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   AppBarConfig appBarConfiguration(MainPageViewModel viewModel) {
//     return AppBarConfig(
//       title: 'AQUAHOME',
//     );
//   }
// }
