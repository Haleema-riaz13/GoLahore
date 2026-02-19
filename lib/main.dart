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

    // Initialize the animation controller for entry effects
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Define the fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Define the subtle zoom-out scale animation
    _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutSine),
    );

    // Start entry animations
    _controller.forward();

    // Timer to replace splash screen with display screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
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
    // Clean up controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image with scaling and fade animations
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

          // Gradient overlay for better text readability
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
                  // App Title: GO
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
                  // App Title: LAHORE
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
                        // Tagline
                        Text(
                          'Explore. Experience. Love the Living City.✨❤️',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Circular Loading bar that fills over 5 seconds
                        Center(
                          child: Column(
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 5),
                                builder: (context, value, child) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Static background circle
                                      CircularProgressIndicator(
                                        value: 1.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white10),
                                        strokeWidth: 4,
                                      ),
                                      // Dynamic progress circle
                                      CircularProgressIndicator(
                                        value: value,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                        strokeWidth: 4,
                                      ),
                                      // Display percentage text
                                      Text(
                                        "${(value * 100).toInt()}%",
                                        style: const TextStyle(fontSize: 10, color: Colors.white54),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              // Loading status text
                              Text(
                                "Loading Experience...",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.orange.withOpacity(0.8),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
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