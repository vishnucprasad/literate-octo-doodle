import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RevealAnimation extends HookWidget {
  final Widget child;
  const RevealAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    )..forward();

    final animation = useAnimation(
      Tween<double>(
        begin: 0,
        end: 2,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
    );

    return ClipOval(clipper: RevealClipper(animation), child: child);
  }
}

class RevealClipper extends CustomClipper<Rect> {
  final double progress;

  RevealClipper(this.progress);

  @override
  Rect getClip(Size size) {
    double radius = size.longestSide * progress;
    return Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
  }

  @override
  bool shouldReclip(RevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
