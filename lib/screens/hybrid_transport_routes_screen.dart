import 'package:flutter/material.dart';
import 'our_trip_screen.dart'; // Ensure correct path for navigation

class HybridTransportRoutesScreen extends StatelessWidget {
  final String language;

  const HybridTransportRoutesScreen({super.key, this.language = "English"});

  @override
  Widget build(BuildContext context) {
    // Boolean check to toggle Urdu strings
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Go back to the main search/map screen
        ),
        title: Text(
          isUrdu ? "ہائبرڈ روٹس (کم پیدل)" : "Hybrid Routes (Least Walk)",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Route Option 1: Rickshaw for First Mile + Orange Line for Long Distance ---
          _buildHybridCard(
            context,
            title: isUrdu ? "ڈی ایچ اے سے ریلوے اسٹیشن" : "DHA to Railway Station",
            steps: [
              {"mode": isUrdu ? "رکشہ" : "Rickshaw", "icon": Icons.electric_rickshaw, "detail": "DHA Ph 6 -> Thokar"},
              {"mode": isUrdu ? "اورنج لائن" : "Orange Line", "icon": Icons.train, "detail": "Thokar -> Station"},
            ],
            iconsString: "🛺 + 🚆", // Identifiers for the live map to draw paths
            price: "Rs. 390",
            duration: "45 min",
            color: const Color(0xFF1B4F72),
          ),
          const SizedBox(height: 16),

          // --- Route Option 2: Bike for Quick Transit + Metro Bus for Cheap Corridor ---
          _buildHybridCard(
            context,
            title: isUrdu ? "جوہر ٹاؤن سے عرفہ ٹاور" : "Johar Town to Arfa Tower",
            steps: [
              {"mode": isUrdu ? "بائیک" : "Bike", "icon": Icons.directions_bike, "detail": "J.Town -> Model Town"},
              {"mode": isUrdu ? "میٹرو بس" : "Metro Bus", "icon": Icons.directions_bus, "detail": "M.Town -> Arfa Tower"},
            ],
            iconsString: "🏍️ + 🚌", // Identifiers for path rendering in OurTripScreen
            price: "Rs. 150",
            duration: "30 min",
            color: const Color(0xFF145A32),
          ),

          const SizedBox(height: 20),
          // Descriptive footer note explaining the hybrid philosophy
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              isUrdu ? "* ہائبرڈ موڈ میں وقت اور بچت دونوں کا خیال رکھا جاتا hai" : "* Hybrid mode balances time and cost savings.",
              style: const TextStyle(color: Colors.white38, fontSize: 12, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build cards that represent multi-leg (Hybrid) journeys
  Widget _buildHybridCard(
      BuildContext context, {
        required String title,
        required List<Map<String, dynamic>> steps,
        required String iconsString,
        required String price,
        required String duration,
        required Color color,
      }) {
    bool isUrdu = language == "Urdu";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Updated from .withOpacity() to .withValues() for latest Flutter versions
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Localized Route Heading
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // --- Visual Step Connector: Renders icons with a horizontal divider between them ---
          Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                Column(
                  children: [
                    Icon(steps[i]['icon'] as IconData, color: Colors.white, size: 28),
                    const SizedBox(height: 5),
                    Text(steps[i]['mode'] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                // Draw a connecting line between modes if it's not the last one in the list
                if (i < steps.length - 1)
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(color: Colors.white54, thickness: 2, height: 40),
                    ),
                  ),
              ]
            ],
          ),

          const SizedBox(height: 15),
          // Textual descriptions for each leg of the hybrid journey
          for (var step in steps)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.greenAccent, size: 14),
                  const SizedBox(width: 8),
                  Text(step['detail'] as String, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),

          const Divider(color: Colors.white10, height: 30),
          // Price and Time summary footer for the card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.orangeAccent, size: 16),
                    const SizedBox(width: 5),
                    Text(duration, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
          // Navigation trigger to start the live trip tracking
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Navigate to OurTripScreen, passing the combined icons string for map pathing
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OurTripScreen(
                      modeTitle: isUrdu ? "ہائبرڈ سفر" : "Hybrid Trip",
                      icons: iconsString,
                      price: price,
                      time: duration,
                      language: language,
                    ),
                  ),
                );
              },
              child: Text(isUrdu ? "سفر شروع کریں" : "START TRIP"),
            ),
          ),
        ],
      ),
    );
  }
}