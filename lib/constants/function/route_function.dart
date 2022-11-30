import 'package:flutter/material.dart';

Route createRoute({
  required Widget screen,
  Offset begin = const Offset(0.0, 1.0),
  Offset end = Offset.zero,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
