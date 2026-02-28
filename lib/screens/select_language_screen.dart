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
  // Variable to track which language option is currently selected
  String selectedLang = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Background Layer: Mosque image with low opacity for visual consistency
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

                  // UPDATED: App Branding - Orange Icon with White Outline
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3), // White Outline
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orangeAccent, // Orange Background
                      child: Icon(Icons.language, color: Colors.white, size: 40),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Select Language",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please choose your preferred language to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                  const SizedBox(height: 50),

                  // Language Selection List
                  _buildLangTile("English", "English", Icons.abc),
                  _buildLangTile("Urdu", "اردو", Icons.translate),
                  _buildLangTile("Roman Urdu", "Roman Urdu", Icons.history_edu),

                  const Spacer(),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLang != "" ? Colors.orangeAccent : Colors.grey.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: selectedLang != ""
                          ? () {
                        Navigator.pushReplacement(
                          context,
                          createSmoothRoute(UserModeScreen(language: selectedLang)),
                        );
                      }
                          : null,
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

  /// Helper widget to build a selectable language card
  Widget _buildLangTile(String title, String subtitle, IconData icon) {
    bool isSelected = selectedLang == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLang = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orangeAccent.withOpacity(0.15) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orangeAccent : Colors.white10,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? Colors.orangeAccent : Colors.white10,
              child: Icon(icon, color: isSelected ? Colors.white : Colors.white60, size: 20),
            ),
            const SizedBox(width: 15),
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