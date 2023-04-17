import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/controls/action_button.dart';
import 'package:aquahome_app/controls/confirm_button.dart';
import 'package:aquahome_app/main_page/view_models/main_page_view_model.dart';
import 'package:aquahome_app/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../style/fonts.dart';
import '../../style/theme_colors.dart';
import '../cells/light_control_item.dart';

class MainPageView extends PageWidget<MainPageViewModel> {
  const MainPageView({super.key});

  @override
  Widget build(
      BuildContext context, MainPageViewModel viewModel, ThemeColors themeColors) {
    return Consumer<MainPageViewModel>(builder: (context, viewModel, child) =>  viewModel.lightsCollection.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
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
            })
        : Container(
            alignment: Alignment.center,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Нет доступных модулей',
                    style: TextStyle(
                        fontFamily: textLight,
                        fontSize: 16,
                        color: themeColors.primaryTextColor)),
                const SizedBox(height: 4),
                ConfirmButton(
                    onTap: () => viewModel.addModule(), text: 'Добавить')
              ],
            ),
          ));
  }

  @override
  AppBarConfig appBarConfiguration(MainPageViewModel viewModel) {
    return AppBarConfig(title: 'AQUAHOME', actionList: [
      ActionButton(onTap: () => viewModel.showOptions(), icon: 'assets/icons/additionally_icon.png',),
    ]);
  }
}

// class AnimatedButton extends StatefulWidget {
//   late SMIBool? input;
//   final Future<Function> Function() onTap;
//
//   AnimatedButton({Key? key, this.input, required this.onTap}) : super(key: key);
//
//   @override
//   State<AnimatedButton> createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton> {
//   bool buttonState = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ZoomTapAnimation(
//       onTap: () async {
//         widget.input?.change(true);
//         await Future.delayed(const Duration(milliseconds: 720));
//         Function result = await widget.onTap();
//         widget.input?.change(false);
//         await Future.delayed(const Duration(milliseconds: 1), () => result.call());
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: SizedBox(
//           height: 28,
//           width: 28,
//           child: RiveAnimation.asset(
//             'assets/animated_icons/additionally_anim_icon.riv',
//             onInit: (artboard) {
//               final controller = RiveUtils.getRiveController(artboard);
//               widget.input = controller.findSMI('state') as SMIBool;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
