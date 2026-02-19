import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'select_language_screen.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Transition added here to navigate to SelectLanguageScreen on tap
        onTap: () {
          Navigator.of(context).push(
            createSmoothRoute(const SelectLanguageScreen()),
          );
        },
        child: Stack(
          children: [
            // Background Image with a fallback color in case of error
            Positioned.fill(
              child: Image.asset(
                'assets/mosque.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
              ),
            ),

            // Dark Gradient Overlay for improved text contrast
            const GradientOverlay(color: Colors.black, opacity: 0.3, endOpacity: 0.6),

            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // Professional Logo with Focused Bus Icon and Shadow Effects
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff3d82cd).withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer Glassmorphism Layer
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                                width: 1.5,
                              ),
                            ),
                          ),
                          // Inner Icon: High-impact Bus Icon
                          const Icon(
                            Icons.directions_bus_rounded,
                            size: 80,
                            color: Color(0xff1a237e),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  // App Title with Border effect
                  const BorderedTitle(title: "GO LAHORE"),
                  const SizedBox(height: 15),
                  // App Subtitle / Description
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "An Intelligent route advisor for multimodal transport",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // User Instruction
                  const Text(
                    "Tap to continue",
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}