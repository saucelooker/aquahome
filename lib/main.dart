import 'package:aquahome_app/base/page_widget.dart';
import 'package:aquahome_app/routes.dart';
import 'package:aquahome_app/services/navigation_service.dart';
import 'package:aquahome_app/settings_page/views/settings_page_view.dart';
import 'package:aquahome_app/splash/splash_page_view.dart';
import 'package:aquahome_app/style/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'base/general_data.dart';
import 'datail_page/views/detail_page_view.dart';
import 'dependency_initializer.dart';
import 'generated/l10n.dart';
import 'instruction_page/instruction_page_view.dart';
import 'main_page/views/main_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  registerRepositories();
  registerGeneralData();
  registerViewModels();
  await serviceLocator<GeneralData>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GeneralData>.value(
        value: serviceLocator<GeneralData>(),
        child: Consumer<GeneralData>(
            builder: (context, generalData, widget) => MaterialApp(
              debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: serviceLocator<GeneralData>().getCurrentLocale(),
                  theme: ThemeData(
                      extensions: <ThemeExtension<dynamic>>[lightTheme]),
                  darkTheme: ThemeData(
                      extensions: <ThemeExtension<dynamic>>[darkTheme]),
                  themeMode: serviceLocator<GeneralData>().theme,
                  navigatorKey:
                      serviceLocator<NavigationService>().navigatorKey,
                  home: const SplashPageView(),
                  onGenerateRoute: (settings) {
                    if (settings.name == detailPageRoute) {
                      return slideRouting(settings, DetailPageView());
                    } else if (settings.name == searchPageRoute) {
                      return slideRouting(
                          settings, const InstructionPageView());
                    } else if (settings.name == settingPageRoute) {
                      return slideRouting(settings, const SettingsPageView());
                    }
                    return fadeRouting(settings, const MainPageView());
                  },
                )));
  }

  PageRouteBuilder slideRouting(RouteSettings settings, PageWidget view) {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        settings: settings,
        pageBuilder: (c, a, an) => view,
        transitionsBuilder: (context, animation, an, child) => SlideTransition(
              position: Tween(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                ),
              ),
              child: child,
            ));
  }

  PageRouteBuilder fadeRouting(RouteSettings settings, Widget view) {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        settings: settings,
        pageBuilder: (c, a, an) => view,
        transitionsBuilder: (context, animation, an, child) => FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                ),
              ),
              child: child,
            ));
  }
}
