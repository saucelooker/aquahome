import 'dart:async';

import 'package:flutter/material.dart';

class RectThumbShape implements SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;
  final Color color;
  final double width;
  final double height;

  const RectThumbShape(
      {this.thumbRadius = 7,
      required this.color,
      this.min = 0,
      this.max = 10,
      this.width = 18,
      this.height = 46});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete,
      {TextPainter? labelPainter, double? textScaleFactor}) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: width, height: height),
        Radius.circular(thumbRadius));

    canvas.drawRRect(rRect, paint);
  }
}

class RectValueIndicatorShape implements SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;
  final Color color;
  final double width;
  final double height;
  final bool show;

  const RectValueIndicatorShape(
      {this.thumbRadius = 5,
      required this.color,
      this.min = 0,
      this.max = 10,
      this.width = 18,
      this.height = 46,
      this.show = true});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete,
      {TextPainter? labelPainter, double? textScaleFactor}) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    if (sliderTheme.showValueIndicator == ShowValueIndicator.never || !show) {
      return;
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(center.dx, center.dy - 10),
            width: width - 4,
            height: height - 24),
        Radius.circular(thumbRadius));

    canvas.drawRRect(rRect, paint);
  }
}

class RectTickMarkShape implements RoundSliderTickMarkShape {
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  const RectTickMarkShape(
      {this.width = 2,
      this.height = 8,
      this.activeColor = Colors.transparent,
      this.inactiveColor = Colors.transparent});

  @override
  Size getPreferredSize(
      {required SliderThemeData sliderTheme, required bool isEnabled}) {
    return Size.fromRadius(tickMarkRadius!);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      required bool isEnabled}) {
    final bool isTickMarkRightOfThumb = center.dx > thumbCenter.dx;
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color =
          ColorTween(end: isTickMarkRightOfThumb ? inactiveColor : activeColor)
              .evaluate(enableAnimation)! //Thumb Background Color
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: width, height: height),
        Radius.circular(tickMarkRadius!));

    canvas.drawRRect(rRect, paint);
  }

  @override
  double? get tickMarkRadius => 2;
}

class RectTrackMarkShape implements RoundedRectSliderTrackShape {
  final Color activeColor;
  final Color inactiveColor;
  final LinearGradient? gradient;
  final double width;
  final double height;

  const RectTrackMarkShape(
      {this.activeColor = Colors.transparent,
      this.inactiveColor = Colors.transparent,
      this.width = 2,
      this.height = 50,
      this.gradient});

  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    const double trackLeft = 11;
    double trackTop = height / 2;
    final double trackRight = parentBox.size.width - 11;
    double trackBottom = height / 2;
    return Rect.fromLTRB(trackLeft, trackTop, trackRight, trackBottom);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 0}) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final ColorTween activeTrackColorTween =
        ColorTween(begin: inactiveColor, end: activeColor);
    final ColorTween inactiveTrackColorTween =
        ColorTween(begin: activeColor, end: inactiveColor);
    final Paint activePaint;
    final Paint inactivePaint;
    if (gradient != null) {
      activePaint = Paint()..shader = gradient!.createShader(trackRect);
      inactivePaint = Paint()..shader = gradient!.createShader(trackRect);
    } else {
      activePaint = Paint()
        ..color = activeTrackColorTween.evaluate(enableAnimation)!;
      inactivePaint = Paint()
        ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    }

    if (gradient != null) {
      final deltaRight = ((height - 36) / trackRect.right * (thumbCenter.dx));
      final deltaLeft = (height - 36) - deltaRight;

      final leftPath = Path();
      leftPath.moveTo(thumbCenter.dx, 0);
      leftPath.quadraticBezierTo(
          thumbCenter.dx - 11, 0, thumbCenter.dx - 11, 9);
      leftPath.conicTo(thumbCenter.dx - 11, height - 9 - deltaLeft,
          (trackRect.left - 11), height - 9 - deltaLeft, 2.5);
      leftPath.quadraticBezierTo((trackRect.left - 11), thumbCenter.dy + 11,
          (trackRect.left - 11), thumbCenter.dy + 20);
      leftPath.lineTo(trackRect.left - 11, height - 9);
      leftPath.quadraticBezierTo(
          trackRect.left - 11, height, trackRect.left - 2, height);
      leftPath.lineTo(thumbCenter.dx, height);
      context.canvas.drawPath(leftPath, activePaint);

      final rightPath = Path();
      rightPath.moveTo(thumbCenter.dx, 0);
      rightPath.quadraticBezierTo(
          thumbCenter.dx + 11, 0, thumbCenter.dx + 11, 9);
      rightPath.conicTo(thumbCenter.dx + 11, height - 9 - deltaRight,
          (trackRect.right + 11), height - 9 - deltaRight, 2.5);
      rightPath.quadraticBezierTo((trackRect.right + 11), thumbCenter.dy + 11,
          (trackRect.right + 11), thumbCenter.dy + 20);
      rightPath.lineTo(trackRect.right + 11, height - 9);
      rightPath.quadraticBezierTo(
          trackRect.right + 11, height, trackRect.right + 2, height);
      rightPath.lineTo(thumbCenter.dx, height);
      context.canvas.drawPath(rightPath, inactivePaint);
    } else {
      const Radius trackRadius = Radius.circular(9);
      context.canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          trackRect.left - 11,
          height,
          thumbCenter.dx + 11,
          0,
          topRight: trackRadius,
          bottomRight: trackRadius,
          topLeft: trackRadius,
          bottomLeft: trackRadius,
        ),
        activePaint,
      );
      context.canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            thumbCenter.dx, height, trackRect.right + 11, 0,
            topRight: trackRadius,
            bottomRight: trackRadius,
            topLeft: inactiveColor == Colors.transparent
                ? trackRadius
                : const Radius.circular(0),
            bottomLeft: inactiveColor == Colors.transparent
                ? trackRadius
                : const Radius.circular(0)),
        inactivePaint,
      );
    }
  }
}
