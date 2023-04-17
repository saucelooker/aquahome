import 'package:aquahome_app/base/appbar_config.dart';
import 'package:aquahome_app/base/base_bl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../dependency_initializer.dart';
import '../style/fonts.dart';
import '../style/theme_colors.dart';

abstract class PageWidget<T extends BaseBl> extends StatefulWidget {
  const PageWidget({
    Key? key,
  }) : super(key: key);

  Widget? build(BuildContext context, T viewModel, ThemeColors themeColors) => null;

  AppBarConfig appBarConfiguration(T viewModel) => AppBarConfig();

  @override
  State<PageWidget> createState() => PageWidgetState<T>();
}

class PageWidgetState<T extends BaseBl>
    extends State<PageWidget<T>> {
  T viewModel = serviceLocator<T>();

  @mustCallSuper
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationParams = ModalRoute.of(context)!.settings.arguments;
    final themeColors = Theme.of(context).extension<ThemeColors>()!;
    if (navigationParams != null) {
      viewModel.init(navigationParams);
    }
    final config = widget.appBarConfiguration(viewModel);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: themeColors.backgroundColor,
              systemNavigationBarIconBrightness:
                  themeColors.theme == ThemeMode.dark
                      ? Brightness.light
                      : Brightness.dark,
              statusBarColor: themeColors.backgroundColor,
              statusBarIconBrightness:
                  themeColors.theme == ThemeMode.dark
                      ? Brightness.light
                      : Brightness.dark),
          backgroundColor: config.transparentBackground
              ? Colors.transparent
              : themeColors.backgroundColor,
          titleSpacing: config.showBackButton ? 0 : 16,
          leadingWidth: config.showBackButton ? 46 : 0,
          actions: config.actionList,
          leading: config.showBackButton
              ? IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  onPressed: () => viewModel.onBackButton(),
                  icon: Image.asset(
                    'assets/icons/back_icon.png',
                    height: 24,
                    width: 20,
                    color: themeColors.primaryTextColor,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                )
              : const SizedBox(),
          title: Hero(
            tag: config.title,
            createRectTween: (b, e) =>
                MaterialRectCenterArcTween(begin: b, end: e),
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                config.title,
                style: TextStyle(
                    fontFamily: textLight,
                    color: themeColors.primaryTextColor,
                    fontSize: 24),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: themeColors.backgroundColor,
        body: SafeArea(
          top: false,
          child: ChangeNotifierProvider<T>.value(
              value: viewModel, child: widget.build(context, viewModel, Theme.of(context).extension<ThemeColors>()!)),
        ));
  }
}