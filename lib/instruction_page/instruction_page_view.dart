import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/base_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../style/theme_colors.dart';
import 'instruction_page_view_model.dart';
import 'instruction_slides/instruction_card.dart';
import 'instruction_slides/instruction_carousel.dart';

class InstructionPageView extends BasePageView<InstructionPageViewModel> {
  const InstructionPageView({super.key});

  @override
  Widget build(BuildContext context, InstructionPageViewModel viewModel,
      ThemeColors themeColors) {
    return Consumer<InstructionPageViewModel>(
        builder: (context, viewModel, child) {
      final Widget dialog;
      switch (viewModel.connectionState) {
        case ConnectionStatus.briefing:
          dialog = InstructionCarousel(
              key: Key(ConnectionStatus.briefing.toString()),
              onConnection: () => viewModel
                  .changeConnectionStatus(ConnectionStatus.connection));
          break;
        case ConnectionStatus.connection:
          dialog = InstructionCard().setCard(
              context,
              'Подключение к модулю.',
              'assets/images/connection_image.png',
              237,
              'Не сворачивайте и не закрывайте приложение, подключение займет не более 30 секунд.',
              key: ConnectionStatus.connection.toString(),
              loading: true);
          break;
        case ConnectionStatus.entry:
          dialog = InstructionCard().setCard(
              context,
              'Для подключения требуется пароль wi-fi сети.',
              'assets/images/entry_image.png',
              218,
              'Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.',
              key: ConnectionStatus.entry.toString(),
              cancelButtonName: 'Отмена',
              onCancel: () => viewModel.onBackButton(),
              confirmButtonName: 'Далее',
              onConfirm: () => viewModel.savePassword(),
              onPassword: (password) =>
                  viewModel.routerParameters.password = password);
          break;
        case ConnectionStatus.success:
          dialog = InstructionCard().setCard(
              context,
              'Модуль успешно подключен.',
              'assets/images/success_image.png',
              237,
              'Далее Вы сможете изменить название и добавить описание.',
              key: ConnectionStatus.success.toString(),
              confirmButtonName: 'Ok',
              onConfirm: () => viewModel.onBackButton());
          break;
        default:
          dialog = InstructionCard().setCard(
              context,
              'При подключении модуля произошла ошибка.',
              'assets/images/error_image.png',
              237,
              viewModel.error?? 'Чтобы повторить подключение, удерживайте кнопку «Reset» в течение 2 секунд, пока световой индикатор не начнёт мигать жёлтым цветом. Затем нажмите кнопку "Повторить"',
              key: ConnectionStatus.error.toString(),
              cancelButtonName: 'Отмена',
              onCancel: () => viewModel.onBackButton(),
              confirmButtonName: 'Повторить',
              onConfirm: () => viewModel
                  .changeConnectionStatus(ConnectionStatus.connection));

          break;
      }

      return WillPopScope(
        onWillPop: () => Future.value(
            viewModel.connectionState == ConnectionStatus.briefing ||
                viewModel.connectionState == ConnectionStatus.error ||
                viewModel.connectionState == ConnectionStatus.entry),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25),
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: AnimatedSwitcher(
                layoutBuilder: (currentChild, previousChild) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      ...previousChild,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                switchInCurve: Curves.easeInOutSine,
                switchOutCurve: Curves.easeInOutSine,
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final inAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation);
                  final outAnimation = Tween<Offset>(
                          begin: const Offset(-1.0, 0.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation);

                  if (child.key ==
                      ValueKey(viewModel.connectionState.toString())) {
                    return SlideTransition(
                      position: inAnimation,
                      child: child,
                    );
                  } else {
                    return SlideTransition(
                      position: outAnimation,
                      child: child,
                    );
                  }
                },
                child: dialog),
          ),
        ),
      );
    });
  }

  @override
  AppBarConfig appBarConfiguration(InstructionPageViewModel viewModel) {
    return AppBarConfig(showBackButton: true, transparentBackground: true);
  }
}
