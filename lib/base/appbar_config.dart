import 'package:flutter/cupertino.dart';

class AppBarConfig {
  final String title;
  final bool showBackButton;
  final List<Widget>? actionList;
  final bool transparentBackground;

  AppBarConfig(
      {this.title = '',
      this.showBackButton = false,
      this.actionList,
      this.transparentBackground = false});
}
