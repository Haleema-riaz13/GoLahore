import 'package:flutter/material.dart';
import 'help_support_screen.dart';

class SafetyModeScreen extends StatelessWidget {
  final String language; // Holds the current language state passed from previous screens (English, Urdu, or Roman Urdu)

  const SafetyModeScreen({super.key, this.language = "English"});

  // --- Translation Helper ---
  // Returns the appropriate string based on the current language selection state
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Pops the current screen to return to the previous one
        ),
        title: Text(
          _t("حفاظتی موڈ", "Safety Mode", "Safety Mode"),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background Layer: Themed mosque image with low opacity for branding consistency
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Interactive SOS Button: High-priority trigger for emergency signals
                GestureDetector(
                  onTap: () {
                    // Triggers a visual confirmation via SnackBar when the emergency signal is "sent"
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_t("ہنگامی SOS سگنل بھیج دیا گیا!", "Emergency SOS Signal bhej diya gaya!", "Emergency SOS Signal Sent!")),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      // Updated from .withOpacity() to .withValues() for modern Flutter standards
                      color: Colors.red.withValues(alpha: 0.2), // Outer glowing ring
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.redAccent, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent, // Solid inner button
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.red, blurRadius: 20, spreadRadius: 5)
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "SOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // SOS Guidance Text: Prominent heading and descriptive instruction
                Text(
                  _t("کیا آپ کسی مشکل میں ہیں؟", "Kya aap emergency mein hain?", "Are you in an emergency?"),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  _t("بٹن دبانے سے آپ کے ہنگامی رابطوں اور حکام ko آپ کی لائیو لوکیشن بھیج دی جائے گی۔",
                      "SOS button dabanay se live location authorities aur contacts ko chali jaye gi.",
                      "Pressing the SOS button will notify your emergency contacts and local authorities with your live location."),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 50),

                // Secondary Safety Actions: Modular components for location sharing and contacts
                _buildSafetyAction(
                  icon: Icons.share_location,
                  label: _t("لائیو لوکیشن شیئر کریں", "Live Location Share Karein", "Share Live Location"),
                  color: Colors.blueAccent,
                  onTap: () {
                    // Logic placeholder for starting a live location sharing session
                  },
                ),
                const SizedBox(height: 15),
                _buildSafetyAction(
                  icon: Icons.contact_emergency,
                  label: _t("ہنگامی رابطے", "Emergency Contacts", "Emergency Contacts"),
                  color: Colors.greenAccent,
                  onTap: () {
                    // Navigation logic to the Help & Support module, passing the language state
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpSupportScreen(language: language),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                _buildSafetyAction(
                  icon: Icons.local_police,
                  label: _t("قریبی پولیس اسٹیشن کال کریں", "Nearest Police ko call karein", "Call Nearest Police Station"),
                  color: Colors.orangeAccent,
                  onTap: () {
                    // Logic placeholder for triggering the system's phone dialer
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent action rows for safety features to ensure UI uniformity
  Widget _buildSafetyAction({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // Dark card surface for high contrast
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color), // Color-coded icon for quick identification
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}