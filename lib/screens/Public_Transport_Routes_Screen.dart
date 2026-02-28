import 'package:flutter/material.dart';
import 'our_trip_screen.dart'; // Make sure the path is correct

class PublicTransportRoutesScreen extends StatelessWidget {
  final String language;

  const PublicTransportRoutesScreen({super.key, this.language = "English"});

  @override
  Widget build(BuildContext context) {
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isUrdu ? "عوامی نقل و حمل کے راستے" : "Public Transport Routes",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Route 1 Card
          _buildRouteCard(
            context,
            title: isUrdu ? "شاہدرہ سے گجومتہ" : "Shahdara to Gajjumata",
            subtitle: isUrdu
                ? "میٹرو بس + سپیڈو + لوکل وین"
                : "Metro Bus + Speedo + Local Van",
            icons: [Icons.directions_bus, Icons.bus_alert, Icons.airport_shuttle],
            // Data passed to OurTripScreen
            iconsString: "🚌 + 🚌 + 🚐",
            price: "Rs. 60",
            duration: "55 min",
            color: const Color(0xFF2E4053),
          ),
          const SizedBox(height: 16),

          // Route 2 Card
          _buildRouteCard(
            context,
            title: isUrdu ? "ٹھوکر نیاز بیگ سے ریلوے اسٹیشن" : "Thokar Niaz Baig to Railway Station",
            subtitle: isUrdu
                ? "اورنج لائن + سپیڈو + چنگچی"
                : "Orange Line + Speedo + Qingqi",
            icons: [Icons.train, Icons.directions_bus, Icons.electric_rickshaw],
            // Data passed to OurTripScreen
            iconsString: "🚆 + 🚌 + 🛺",
            price: "Rs. 80",
            duration: "40 min",
            color: const Color(0xFF512E5F),
          ),

          const SizedBox(height: 25),
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
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: icons.map((icon) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Colors.white70, size: 24),
            )).toList(),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const Divider(color: Colors.white10, height: 25),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Navigation to OurTripScreen with data
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