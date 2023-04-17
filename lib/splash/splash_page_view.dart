import 'package:aquahome_app/dependency_initializer.dart';
import 'package:aquahome_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../style/fonts.dart';
import '../style/theme_colors.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({Key? key}) : super(key: key);

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.forward();
    Future.delayed(const Duration(seconds: 1), () {
      serviceLocator<NavigationService>().navigationTo('//', isHome: true);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Scaffold(
        appBar:
        AppBar(
            elevation: 0,
            toolbarHeight: 1,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.lerp(const Color(0xff111111),
                    themeColors.backgroundColor, _animationController.value),
                systemNavigationBarColor: Color.lerp(const Color(0xff111111),
                    themeColors.backgroundColor, _animationController.value))),
        backgroundColor: Color.lerp(const Color(0xff111111),
            themeColors.backgroundColor, _animationController.value),
        body: Align(
          alignment: Alignment.center,
          child: Hero(
            tag: 'AQUAHOME',
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'AQUAHOME',
                style: TextStyle(
                    fontFamily: textLight,
                    color: themeColors.primaryTextColor,
                    fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
