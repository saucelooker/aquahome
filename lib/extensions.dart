import 'dart:ui';

import 'package:aquahome_app/style/constants.dart';
import 'package:flutter/cupertino.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension AnimatedListExtension on List {
  animatedInsert(int index, dynamic item, GlobalKey<AnimatedListState> key) {
    insert(index, item);
    key.currentState?.insertItem(0, duration: const Duration(milliseconds: fadeAnimationTime));
  }

  // animatedRemove(dynamic item, GlobalKey<AnimatedListState> key) {
  //   int index = indexOf(item);
  //
  //   key.currentState?.removeItem(
  //       index);
  // }

}