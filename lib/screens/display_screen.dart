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
        // Transition to navigate to SelectLanguageScreen on tap
        onTap: () {
          Navigator.of(context).push(
            createSmoothRoute(const SelectLanguageScreen()),
          );
        },
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/mosque.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
              ),
            ),

            // Dark Gradient Overlay
            const GradientOverlay(color: Colors.black, opacity: 0.3, endOpacity: 0.6),

            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // Professional Logo Section
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            // Shadow brightness kam kar di gayi hai
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // UPDATED: Outer Circle - Simple Flat Orange (No Gradient)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE67E22), // Simple Flat Orange
                              border: Border.all(
                                color: Colors.white.withOpacity(0.8),
                                width: 2.5,
                              ),
                            ),
                          ),
                          // Inner Bus Icon - Now White
                          const Icon(
                            Icons.directions_bus_rounded,
                            size: 75,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  // App Title
                  const BorderedTitle(title: "GO LAHORE"),
                  const SizedBox(height: 15),
                  // App Subtitle
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