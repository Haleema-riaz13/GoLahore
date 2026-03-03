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
        // Logic: Navigates to the language selection screen when the user taps anywhere
        onTap: () {
          Navigator.of(context).push(
            createSmoothRoute(const SelectLanguageScreen()),
          );
        },
        child: Stack(
          children: [
            // Background Layer: High-quality visual of a mosque representing Lahore
            Positioned.fill(
              child: Image.asset(
                'assets/mosque.jpg',
                fit: BoxFit.cover,
                // Fallback UI in case the asset fails to load
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
              ),
            ),

            // Visual Overlay: Dark gradient to ensure the white text and logo remain readable
            const GradientOverlay(color: Colors.black, opacity: 0.3, endOpacity: 0.6),

            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // --- Central Branding Section ---
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            // Subtle shadow to create depth without overwhelming the background
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Flat Orange Brand Circle: Minimalist design
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE67E22),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.8),
                                width: 2.5,
                              ),
                            ),
                          ),
                          // Core App Icon: Representing transport
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
                  // Main App Title using a custom bordered widget
                  const BorderedTitle(title: "GO LAHORE"),
                  const SizedBox(height: 15),

                  // App Tagline: Explaining the "Intelligent route advisor" purpose
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

                  const Spacer(), // Pushes the instruction text to the bottom

                  // Interactive Prompt for the user
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