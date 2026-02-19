import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'our_trip_screen.dart';

class RouteResultScreen extends StatefulWidget {
  final String language; // Holds the user's preferred language (Urdu, Roman Urdu, or English)

  const RouteResultScreen({super.key, this.language = "English"});

  @override
  State<RouteResultScreen> createState() => _RouteResultScreenState();
}

class _RouteResultScreenState extends State<RouteResultScreen> {
  // Toggle state for the 'Fastest' category between Bike and Car options
  String selectedFastestOption = "Bike";

  // --- Translation Helper Method ---
  // Returns the appropriate string based on the current language parameter
  String _t(String ur, String ro, String en) {
    if (widget.language == "Urdu") return ur;
    if (widget.language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Background Layer: Mosque themed image with low opacity for branding
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Custom Navigation Bar area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        _t("روٹ کے نتائج", "Route ke Results", "Route Results"),
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Main Scrollable List displaying different travel options
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      // --- OPTION 1: CHEAPEST (Optimized for cost) ---
                      _buildResultCard(
                        context,
                        title: _t("سب سے سستا", "Sabse Sasta", "Cheapest"),
                        mode: _t("عوامی سواری", "Public Transport", "Offline Mode (Public)"),
                        iconsText: "🚶 Walk + 🚇 Metro + 🛺 Qingqi",
                        transportSpans: [
                          const TextSpan(text: "🚇"),
                          const TextSpan(text: " + ", style: TextStyle(color: Colors.white)),
                          const TextSpan(text: "🚌"),
                          const TextSpan(text: " + ", style: TextStyle(color: Colors.white)),
                          const TextSpan(text: "🛺"),
                        ],
                        description: _t("میٹرو بس + سپیڈو + چنگچی", "Metro Bus + Speedo + Qingqi", "Metro Bus + Speedo + Local Qingqi"),
                        price: _t("35 روپے", "Rs 35", "Rs 35"),
                        time: _t("45 منٹ", "45 min", "45 min"),
                        isRainOptimized: false,
                        mapSnippet: Icons.directions_bus,
                        cardColor: Colors.blue.withOpacity(0.15),
                      ),
                      const SizedBox(height: 15),

                      // --- OPTION 2: FASTEST (Optimized for time, dynamic toggle) ---
                      _buildFastestResultCard(),

                      const SizedBox(height: 15),

                      // --- OPTION 3: LEAST WALKING (Optimized for comfort/rain) ---
                      _buildResultCard(
                        context,
                        title: _t("کم پیدل سفر", "Kam Paidal", "Least walking"),
                        mode: _t("ہائبرڈ موڈ", "Hybrid Mode", "Hybrid Mode"),
                        iconsText: "🚆 Orange Line + 🚕 Rickshaw",
                        transportSpans: [
                          const TextSpan(text: "🚆"),
                          const TextSpan(text: " + ", style: TextStyle(color: Colors.white)),
                          const TextSpan(text: "🚕"),
                        ],
                        description: _t("اورنج لائن + ڈور سٹیپ رکشہ", "Orange Line + Doorstep Rickshaw", "Orange Line + Doorstep Rickshaw"),
                        price: _t("90 روپے", "Rs 90", "Rs 90"),
                        time: _t("35 منٹ", "35 min", "35 min"),
                        isRainOptimized: true,
                        mapSnippet: Icons.shuffle,
                        cardColor: Colors.green.withOpacity(0.15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Specialized card for 'Fastest' results featuring a Bike/Car toggle
  Widget _buildFastestResultCard() {
    bool isBike = selectedFastestOption == "Bike";

    // Dynamic data binding based on Bike vs Car selection
    String price = isBike
        ? _t("150 روپے", "Rs 150", "Rs 150")
        : _t("450 روپے", "Rs 450", "Rs 450");

    String time = isBike
        ? _t("20 منٹ", "20 min", "20 min")
        : _t("30 منٹ", "30 min", "30 min");

    String iconsText = isBike
        ? _t("موٹر سائیکل", "Bike", "Bike")
        : _t("کار", "Car", "Car");

    List<TextSpan> transportSpans = isBike
        ? [TextSpan(text: "🏍️ ${_t('بائیک', 'Bike', 'Bike')}")]
        : [TextSpan(text: "🚗 ${_t('کار', 'Car', 'Car')}")];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_t("تیز ترین", "Sabse Tez", "Fastest"), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                child: Text(_t("آن لائن موڈ", "Online Mode", "Online Mode"), style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Toggle buttons for Bike or Car selection
          Row(
            children: [
              _buildSelectionButton(_t("بائیک", "Bike", "Bike"), isBike, "Bike"),
              const SizedBox(width: 10),
              _buildSelectionButton(_t("کار", "Car", "Car"), !isBike, "Car"),
            ],
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 28),
                      children: transportSpans,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_t("براہ راست پرائیویٹ", "Direct Private", "Direct Private") + " $selectedFastestOption", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("$price | $time", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                child: Icon(isBike ? Icons.motorcycle : Icons.directions_car, size: 40, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNavigationButton(_t("آن لائن موڈ", "Online Mode", "Online Mode"), iconsText, price, time),
        ],
      ),
    );
  }

  /// Builder for the toggle buttons (Bike/Car)
  Widget _buildSelectionButton(String label, bool isSelected, String optionKey) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFastestOption = optionKey),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white10,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Generic card builder for standard travel results (Cheapest, Least Walking)
  Widget _buildResultCard(
      BuildContext context, {
        required String title,
        required String mode,
        required String iconsText,
        required List<TextSpan> transportSpans,
        required String description,
        required String price,
        required String time,
        required bool isRainOptimized,
        required IconData mapSnippet,
        required Color cardColor,
      }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                child: Text(mode, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(style: const TextStyle(fontSize: 28), children: transportSpans),
                  ),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("$price | $time", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                child: Icon(mapSnippet, size: 40, color: Colors.white),
              ),
            ],
          ),
          // Conditional UI element for rainy weather optimization
          if (isRainOptimized) ...[
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.umbrella, color: Colors.lightBlueAccent, size: 18),
                const SizedBox(width: 5),
                Text(_t("“بارش کے موسم کے لیے بہترین”", "“Barish ke liye behtar”", "“Best for rainy weather”"), style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 13, fontStyle: FontStyle.italic)),
              ],
            ),
          ],
          const SizedBox(height: 20),
          _buildNavigationButton(mode, iconsText, price, time),
        ],
      ),
    );
  }

  /// Triggers the actual navigation flow to the 'OurTripScreen'
  Widget _buildNavigationButton(String mode, String icons, String price, String time) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Pass all route data to the live trip tracking screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OurTripScreen(
                modeTitle: mode,
                icons: icons,
                price: price,
                time: time,
                language: widget.language,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(_t("نیویگیشن شروع کریں", "Navigation Start Karein", "START NAVIGATION"), style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      ),
    );
  }
}