import 'package:flutter/material.dart';

/// Clean & Standard Smooth Transition: Simple Fade and Slide.
Route createSmoothRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      // Standard smooth curve that provides a natural feel
      var curve = CurvedAnimation(
          parent: animation,
          // LinearToEaseOut: Starts fast and finishes with a smooth deceleration
          curve: Curves.linearToEaseOut
      );

      // Subtle Slide: The screen moves up slightly (5%) as it enters
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.05),
        end: Offset.zero,
      ).animate(curve);

      // Combines Fade and Slide transitions for a premium UI feel
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },

    // Timing: 450ms for a snappy entry and 300ms for a quick reverse transition
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 300),
  );
}