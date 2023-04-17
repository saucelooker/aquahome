import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../controls/interactions/interaction.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigationTo(String routeName,
      {bool isHome = false, Object? navigationParams}) {
    return isHome
        ? navigatorKey.currentState!
            .pushReplacementNamed(routeName, arguments: navigationParams)
        : navigatorKey.currentState!
            .pushNamed(routeName, arguments: navigationParams);
  }

  void goBack([Object? result]) {
    navigatorKey.currentState!.pop(result);
  }

  void showToast(String message) {
    Interaction(navigatorKey.currentContext!).toast(message);
  }

  Future<Object?>? showDialog(Widget widget,
      {bool? dismissible, EdgeInsets? padding, Alignment? alignment, bool softAppearing = true}) async {
    return await Interaction(navigatorKey.currentContext!,
            dismissible: dismissible, padding: padding, alignment: alignment, softAppearing: softAppearing)
        .dialog(widget);
  }
}
