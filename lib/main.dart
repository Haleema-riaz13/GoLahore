import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'screens/display_screen.dart';

void main() {
  runApp(const GoLahoreApp());
}

class GoLahoreApp extends StatelessWidget {
  const GoLahoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoLahore',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutSine),
    );

    _controller.forward();

    // UPDATED: Timer duration changed to 6 seconds (5s loading + 1s stay at 100%)
    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secondAnim) => const DisplayScreen(),
            transitionsBuilder: (context, anim, secondAnim, child) {
              return FadeTransition(opacity: anim, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Image.asset(
                    'assets/metro_dark.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'GO',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 40,
                        color: Colors.orange.shade700,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'LAHORE',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 85,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.9,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore. Experience. Love the Living City.✨❤️',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // UPDATED: Plain Matte Loading Bar (No Shine, No Gradient)
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(seconds: 5),
                          builder: (context, value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6, // Slightly thinner for cleaner look
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Plain Solid Progress Fill
                                      FractionallySizedBox(
                                        widthFactor: value,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.orange.shade700, // Solid Plain Color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Loading Experience...",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.white38,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "${(value * 100).toInt()}%",
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 12,
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}