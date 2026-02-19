import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'search_routes_screen.dart';

class TripCompletionScreen extends StatelessWidget {
  final String price;    // Displays the fare or savings amount
  final String time;     // Displays the total time taken for the journey
  final String language; // Holds the current application language state

  const TripCompletionScreen({
    super.key,
    required this.price,
    required this.time,
    this.language = "English", // Defaulting to English if no parameter is passed
  });

  // --- Translation Helper ---
  // Returns the appropriate string literal based on the selected language
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Layer: Themed mosque image
          Positioned.fill(
            child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
          ),
          // Dark Overlay: Applied for better text contrast and readability
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                // Screen Title with celebration emoji
                Text(
                  _t("سفر مکمل 🎉", "Trip Mukammal 🎉", "Trip Complete 🎉"),
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // Summary Card using Glassmorphism design principles

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Column(
                      children: [
                        // Displaying Trip Summary metrics
                        _buildSummaryRow(Icons.timer_outlined, _t("صرف شدہ وقت", "Time laga", "Time taken"), time),
                        const SizedBox(height: 25),
                        _buildSummaryRow(Icons.account_balance_wallet_outlined, _t("بچت", "Fare bacha", "Fare saved"), price),
                        const SizedBox(height: 25),
                        _buildSummaryRow(Icons.emoji_events_outlined, _t("بیج", "AI badge", "AI badge"), "100 pts"),
                        const SizedBox(height: 30),

                        // User Feedback/Rating Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_t("رائے دیں ⭐", "Rate karein ⭐", "Rate trip ⭐"), style: const TextStyle(color: Colors.white)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  width: 60, height: 40,
                                  color: Colors.white24,
                                  child: Image.asset('assets/map.jpg', fit: BoxFit.cover)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),

                // Confirmation Button: Returns user to the Dashboard
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        // Resets navigation stack and returns to the search screen with persistence
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SearchRoutesScreen(language: language)),
                              (route) => false,
                        );
                      },
                      child: Text(
                          _t("مکمل", "MUKAMMAL", "DONE"),
                          style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent summary data rows with icons
  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}