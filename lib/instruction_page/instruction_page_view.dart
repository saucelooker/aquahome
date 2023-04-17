import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../style/theme_colors.dart';
import 'instruction_page_view_model.dart';
import 'instruction_slides/instruction_card.dart';
import 'instruction_slides/instruction_carousel.dart';

class InstructionPageView extends PageWidget<InstructionPageViewModel> {
  const InstructionPageView({super.key});

  @override
  Widget build(BuildContext context, InstructionPageViewModel viewModel,
      ThemeColors themeColors, S localizations) {
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
              localizations.instructionPageConnection,
              'assets/images/connection_image.png',
              237,
              localizations.instructionPageConnectionDesc,
              key: ConnectionStatus.connection.toString(),
              loading: true);
          break;
        case ConnectionStatus.entry:
          dialog = InstructionCard().setCard(
              context,
              localizations.instructionPageEntry,
              'assets/images/entry_image.png',
              218,
              localizations.instructionPageEntryDesc,
              key: ConnectionStatus.entry.toString(),
              cancelButtonName: localizations.cancel,
              onCancel: () => viewModel.onBackButton(),
              confirmButtonName: localizations.next,
              onConfirm: () => viewModel.savePassword(),
              onPassword: (password) =>
                  viewModel.routerParameters.password = password);
          break;
        case ConnectionStatus.success:
          dialog = InstructionCard().setCard(
              context,
              localizations.instructionPageSuccess,
              'assets/images/success_image.png',
              237,
              localizations.instructionPageSuccessDesc,
              key: ConnectionStatus.success.toString(),
              confirmButtonName: localizations.ok,
              onConfirm: () => viewModel.onBackButton());
          break;
        default:
          dialog = InstructionCard().setCard(
              context,
              localizations.instructionPageError,
              'assets/images/error_image.png',
              237,
              viewModel.error?? localizations.instructionPageErrorDesc,
              key: ConnectionStatus.error.toString(),
              cancelButtonName: localizations.cancel,
              onCancel: () => viewModel.onBackButton(),
              confirmButtonName: localizations.repeat,
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
