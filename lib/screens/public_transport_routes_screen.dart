import 'package:flutter/material.dart';
import 'our_trip_screen.dart'; // Ensure the path is correct for your project structure

class PublicTransportRoutesScreen extends StatelessWidget {
  final String language;

  const PublicTransportRoutesScreen({super.key, this.language = "English"});

  @override
  Widget build(BuildContext context) {
    // Boolean flag to toggle between Urdu and English/Roman Urdu UI strings
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Navigates back to the Search/Map screen
        ),
        title: Text(
          isUrdu ? "عوامی نقل و حمل کے راستے" : "Public Transport Routes",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Route Option 1: North-South Corridor (Metro Centric) ---
          _buildRouteCard(
            context,
            title: isUrdu ? "شاہدرہ سے گجومتہ" : "Shahdara to Gajjumata",
            subtitle: isUrdu
                ? "میٹرو بس + سپیڈو + لوکل وین"
                : "Metro Bus + Speedo + Local Van",
            icons: [Icons.directions_bus, Icons.bus_alert, Icons.airport_shuttle],
            // String containing emojis passed to the OurTripScreen for the live tracker UI
            iconsString: "🚌 + 🚌 + 🚐",
            price: "Rs. 60",
            duration: "55 min",
            color: const Color(0xFF2E4053),
          ),
          const SizedBox(height: 16),

          // --- Route Option 2: East-West Corridor (Train Centric) ---
          _buildRouteCard(
            context,
            title: isUrdu ? "ٹھوکر نیاز بیگ سے ریلوے اسٹیشن" : "Thokar Niaz Baig to Railway Station",
            subtitle: isUrdu
                ? "اورنج لائن + سپیڈو + چنگچی"
                : "Orange Line + Speedo + Qingqi",
            icons: [Icons.train, Icons.directions_bus, Icons.electric_rickshaw],
            // Data mapping for the live trip visualization
            iconsString: "🚆 + 🚌 + 🛺",
            price: "Rs. 80",
            duration: "40 min",
            color: const Color(0xFF512E5F),
          ),

          const SizedBox(height: 25),
          // Disclaimers regarding real-time traffic variations in Lahore
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              isUrdu ? "* کرایہ اور وقت ٹریفک کے مطابق بدل سکتا ہے" : "* Fare and time may vary with traffic",
              style: const TextStyle(color: Colors.white38, fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent route cards with dynamic data injection
  Widget _buildRouteCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required List<IconData> icons,
        required String iconsString,
        required String price,
        required String duration,
        required Color color,
      }) {
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
          // Localized Route Destination
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Row of Icons representing the sequence of transport modes
          Row(
            children: icons.map((icon) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Colors.white70, size: 24),
            )).toList(),
          ),
          const SizedBox(height: 8),
          // Localized list of vehicles used in the route
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const Divider(color: Colors.white10, height: 25),
          // Price and Time Estimation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.payments_outlined, color: Colors.greenAccent, size: 18),
                  const SizedBox(width: 5),
                  Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, color: Colors.orangeAccent, size: 18),
                  const SizedBox(width: 5),
                  Text(duration, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Action Button: Transitions the user to the active tracking experience
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Navigates to OurTripScreen, passing the route configuration and current language
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OurTripScreen(
                      modeTitle: language == "Urdu" ? "عوامی سواری" : "Public Transport",
                      icons: iconsString,
                      price: price,
                      time: duration,
                      language: language,
                    ),
                  ),
                );
              },
              child: Text(language == "Urdu" ? "سفر شروع کریں" : "START TRIP"),
            ),
          ),
        ],
      ),
    );
  }
}