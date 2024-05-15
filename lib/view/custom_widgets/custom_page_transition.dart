import 'package:flutter/material.dart';

PageRouteBuilder createCustomRoute({required Widget targetPage}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => targetPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var slideTween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));

      var fadeTween = Tween(begin: 0.0, end: 1.0);

      var scaleTween = Tween(begin: 0.8, end: 1.0);

      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: SlideTransition(
          position: animation.drive(slideTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        ),
      );
    },
  );
}
