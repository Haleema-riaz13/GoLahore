import 'package:flutter/material.dart';
import 'dart:ui';

// 1. GRADIENT OVERLAY (Used for background images to improve contrast)
class GradientOverlay extends StatelessWidget {
  final Color color;
  final double opacity;
  final double endOpacity;

  const GradientOverlay({
    super.key,
    required this.color,
    required this.opacity,
    this.endOpacity = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Updated from .withOpacity() to .withValues() for modern standards
              color.withValues(alpha: opacity),
              color.withValues(alpha: endOpacity),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. GLASS WRAPPER (Implements the Glassmorphism blur effect)
class GlassWrapper extends StatelessWidget {
  final Widget child;
  const GlassWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            // Updated from .withOpacity() to .withValues() for modern standards
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// 3. PRIMARY ACTION BUTTON (Standard button for Login/Signup actions)
class PrimaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A8CBB), Color(0xFF4285F4)],
        ),
        boxShadow: [
          BoxShadow(
            // Updated from .withOpacity() to .withValues() for modern standards
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// 4. SOCIAL GLASS TAB (Designed for social login options like Google)
class SocialGlassTab extends StatelessWidget {
  final String label;
  final IconData icon;
  const SocialGlassTab({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassWrapper(
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. BORDERED TITLE (Standard title widget for branding, e.g., GO LAHORE)
class BorderedTitle extends StatelessWidget {
  final String title;
  const BorderedTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 2.5,
      ),
    );
  }
}