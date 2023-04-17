import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'dart:math';
import '../style/theme_colors.dart';

class BlurTabBar extends StatelessWidget {
  final void Function(bool) onAddButton;
  final void Function(String) onNavigate;

  const BlurTabBar(
      {Key? key,
      required this.onAddButton,
      required this.onNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Positioned(
      bottom: 0,
      height: 80,
      child: Stack(alignment: Alignment.bottomLeft, children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 58),
              painter: NavigationBarPainter(
                  themeColors.primaryTextColor.withOpacity(0.1)),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 22,
          child: ZoomTapAnimation(
            onTap: () => onAddButton(false),
            onLongTap: () => onAddButton(true),
            child: Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: themeColors.secondaryBackgroundColor,
              ),
              child: Icon(
                Icons.add_rounded,
                size: 32,
                color: themeColors.primaryTextColor,
              ),
            ),
          ),
        ),
      ]),
    )
    ;

  }
}

class NavigationBarPainter extends CustomPainter {
  final Color color;

  NavigationBarPainter(this.color);

  double degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var buttonRadius = 29.0;
    var buttonRadiusBorder = 6.0;
    var buttonSpaceAround = 6.0;

    Path path = Path();
    path.lineTo(
        size.width -
            16 -
            buttonRadius * 2 -
            buttonSpaceAround -
            buttonRadiusBorder,
        0);
    path.quadraticBezierTo(
        size.width - 16 - buttonRadius * 2 - buttonSpaceAround,
        0,
        size.width - 16 - buttonRadius * 2 - buttonSpaceAround,
        buttonRadiusBorder + 2);
    path.arcToPoint(
        Offset(size.width - 16 + buttonSpaceAround, buttonRadiusBorder + 2),
        radius: Radius.circular(buttonRadius),
        clockwise: false);
    path.quadraticBezierTo(size.width - 16 + buttonSpaceAround, 0,
        size.width - 16 + buttonRadiusBorder + buttonSpaceAround, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 58);
    path.lineTo(0, 58);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var buttonRadius = 29.0;
    var buttonRadiusBorder = 6.0;
    var buttonSpaceAround = 6.0;

    Path path = Path();
    path.lineTo(
        size.width -
            16 -
            buttonRadius * 2 -
            buttonSpaceAround -
            buttonRadiusBorder,
        0);
    path.quadraticBezierTo(
        size.width - 16 - buttonRadius * 2 - buttonSpaceAround,
        0,
        size.width - 16 - buttonRadius * 2 - buttonSpaceAround,
        buttonRadiusBorder);
    path.arcToPoint(
        Offset(size.width - 16 + buttonSpaceAround, buttonRadiusBorder),
        radius: Radius.circular(buttonRadius),
        clockwise: true);
    path.quadraticBezierTo(size.width - 16 + buttonSpaceAround, 0,
        size.width - 16 + buttonRadiusBorder + buttonSpaceAround, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 58);
    path.lineTo(0, 58);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
