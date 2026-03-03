import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'user_mode_screen.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  // Variable to track which language option is currently selected by the user
  String selectedLang = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Deep dark theme background
      body: Stack(
        children: [
          // Background Layer: Themed mosque image at very low opacity for a watermark effect
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // App Branding: Language icon inside an orange circle with a thick white border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3), // Decorative White Outline
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orangeAccent, // Primary Brand Color
                      child: Icon(Icons.language, color: Colors.white, size: 40),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Header text for the language selection screen
                  const Text(
                    "Select Language",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Informative subtitle for user guidance
                  const Text(
                    "Please choose your preferred language to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                  const SizedBox(height: 50),

                  // List of available languages rendered using a helper method
                  _buildLangTile("English", "English", Icons.abc),
                  _buildLangTile("Urdu", "اردو", Icons.translate),
                  _buildLangTile("Roman Urdu", "Roman Urdu", Icons.history_edu),

                  const Spacer(), // Pushes the button to the bottom area of the screen

                  // Action Button: Enables only when a language is selected
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // Logic: Highlight button in orange if selected, otherwise keep it grey
                        backgroundColor: selectedLang != "" ? Colors.orangeAccent : Colors.grey.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: selectedLang != ""
                          ? () {
                        // Navigates to the User Mode screen while passing the selected language state
                        Navigator.pushReplacement(
                          context,
                          createSmoothRoute(UserModeScreen(language: selectedLang)),
                        );
                      }
                          : null, // Button is disabled if selectedLang is empty
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build a consistent, interactive language selection tile
  Widget _buildLangTile(String title, String subtitle, IconData icon) {
    // Determines if this specific tile is currently the active selection
    bool isSelected = selectedLang == title;

    return GestureDetector(
      onTap: () {
        // Updates the state and rebuilds the UI to reflect the new selection
        setState(() {
          selectedLang = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Logic: Apply a subtle orange tint and border if the tile is selected
          color: isSelected ? Colors.orangeAccent.withOpacity(0.15) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orangeAccent : Colors.white10,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon representing the language option
            CircleAvatar(
              backgroundColor: isSelected ? Colors.orangeAccent : Colors.white10,
              child: Icon(icon, color: isSelected ? Colors.white : Colors.white60, size: 20),
            ),
            const SizedBox(width: 15),
            // Textual descriptions for the language
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            // Visual checkmark or empty circle to indicate selection state
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFFE67E22), size: 24)
            else
              const Icon(Icons.circle_outlined, color: Colors.white24, size: 24),
          ],
        ),
      ),
    );
  }
}