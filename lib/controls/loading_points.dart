import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingPoints extends StatefulWidget {
  final int? delay;
  final Widget child;

  const LoadingPoints({Key? key, this.delay, required this.child})
      : super(key: key);

  @override
  State<LoadingPoints> createState() => _LoadingPointsState();
}

class _LoadingPointsState extends State<LoadingPoints>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  final Duration duration = const Duration(milliseconds: 1100);
  final Curve curve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween:
              Tween<double>(begin: 1, end: 3.2).chain(CurveTween(curve: curve)),
          weight: 1),
      TweenSequenceItem(
          tween:
              Tween<double>(begin: 3.2, end: 1).chain(CurveTween(curve: curve)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: curve,
      ),
    );

    slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(0, 0), end: const Offset(0, -1.5)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(0, -1.5), end: const Offset(0, 0)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: curve,
      ),
    );

    if (widget.delay == null) {
      _animationController.forward();
      _animationController.repeat(reverse: true);
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        _animationController.forward();
        _animationController.repeat(reverse: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scaleAnimation, child: widget.child);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
