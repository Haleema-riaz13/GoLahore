import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';

class TravelHistoryScreen extends StatelessWidget {
  final String language; // Stores the current application language state

  const TravelHistoryScreen({super.key, this.language = "English"});

  // --- Translation Helper Method ---
  // Selects the appropriate string literal based on the active language parameter
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    // Sample Data: List representing the user's transit history in Lahore
    final List<Map<String, String>> history = [
      {"route": "Arfa Tower → Liberty", "date": "Feb 14, 2026", "fare": "Rs. 40", "mode": "Metro Bus"},
      {"route": "Anarkali → Raiwind", "date": "Feb 12, 2026", "fare": "Rs. 120", "mode": "Speedo Bus"},
      {"route": "Gulberg → Mall Road", "date": "Feb 10, 2026", "fare": "Rs. 80", "mode": "Orange Line"},
      {"route": "DHA Ph 5 → Model Town", "date": "Feb 05, 2026", "fare": "Rs. 250", "mode": "Private Taxi"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Navigate back to the previous screen
        ),
        title: Text(
          _t("سفر کی تاریخ", "Travel History", "Travel History"),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background Layer: Mosque themed image with low opacity for branding consistency
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Section Subheader
                Text(
                  _t("حالیہ مکمل شدہ سفر", "Haaliyah mukammal safar", "Recent Completed Journeys"),
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
                const SizedBox(height: 20),

                // Main List: Rendering history items using a builder for optimal performance
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return _buildHistoryTile(
                        history[index]['route']!,
                        history[index]['date']!,
                        history[index]['fare']!,
                        history[index]['mode']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build individual travel history cards
  Widget _buildHistoryTile(String route, String date, String fare, String mode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Leading: Visual icon based on the transport mode utilized
          CircleAvatar(
            backgroundColor: Colors.blueGrey.withOpacity(0.2),
            child: Icon(
              mode.contains("Metro") ? Icons.directions_bus : Icons.train,
              color: Colors.blueAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),

          // Center: Route details, timestamp, and transport mode
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "$date | $mode",
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          // Trailing: Displaying the fare/cost of the trip
          Text(
            fare,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}