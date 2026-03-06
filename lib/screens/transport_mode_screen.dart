import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Path to the welcome screen
import 'user_mode_screen.dart'; // Path to the user mode screen

class TransportModeScreen extends StatefulWidget {
  final String language;

  const TransportModeScreen({super.key, required this.language});

  @override
  State<TransportModeScreen> createState() => _TransportModeScreenState();
}

class _TransportModeScreenState extends State<TransportModeScreen> {
  // Variable to store the currently selected transport mode
  String? selectedMode;

  @override
  Widget build(BuildContext context) {
    // Localization logic for UI text strings
    String title = widget.language == "Urdu" ? "موڈ منتخب کریں" : "Choose Your Mode";
    String privateText = widget.language == "Urdu" ? "پرائیویٹ موڈ" : "Private Mode";
    String publicText = widget.language == "Urdu" ? "پبلک موڈ" : "Public Mode";
    String btnText = widget.language == "Urdu" ? "آگے بڑھیں" : "CONTINUE";

    return Scaffold(
      body: Stack(
        children: [
          // 1. Full Screen Background Layer with Mosque Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                // Path must match the entry in pubspec.yaml
                image: const AssetImage('assets/mosque.jpg'),
                fit: BoxFit.cover,
                // Dark overlay to ensure white text is readable
                colorFilter: ColorFilter.mode(
                  // Updated from .withOpacity() to .withValues() for modern standards
                  Colors.black.withValues(alpha: 0.65),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // 2. Main UI Layout Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Screen Header Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Selection Card for Private Mode
                  _buildOptionCard(
                    title: privateText,
                    icon: Icons.directions_car_filled_outlined,
                    modeValue: "Private",
                  ),

                  const SizedBox(height: 20),

                  // Selection Card for Public Mode
                  _buildOptionCard(
                    title: publicText,
                    icon: Icons.directions_bus_filled_outlined,
                    modeValue: "Public",
                  ),

                  const Spacer(),

                  // Main Action Button (Continue)
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE28A2B), // Themed Orange color
                        foregroundColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: selectedMode != null
                          ? () {
                        // Navigation logic based on the user's selection
                        if (selectedMode == "Public") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          );
                        } else if (selectedMode == "Private") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserModeScreen(language: widget.language),
                            ),
                          );
                        }
                      }
                          : null, // Button remains disabled if no mode is selected
                      child: Text(
                        btnText,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable helper widget to build the selectable mode options
  Widget _buildOptionCard({required String title, required IconData icon, required String modeValue}) {
    bool isSelected = selectedMode == modeValue;
    return GestureDetector(
      onTap: () => setState(() => selectedMode = modeValue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          // Glassmorphism effect: updated withValues for modern Flutter standards
          color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFE28A2B) : Colors.white24,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Circular container for the mode icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE28A2B) : Colors.white10,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? Colors.black : Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            // Mode Title Text
            Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                )
            ),
            const Spacer(),
            // Visual Radio Button indicator
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFFE28A2B) : Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}