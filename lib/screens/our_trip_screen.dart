import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'trip_completion_screen.dart';

class OurTripScreen extends StatelessWidget {
  final String modeTitle; // Title of the transport mode (e.g., Public, Private)
  final String icons;     // Text/Emoji string representing the travel steps
  final String price;    // Formatted price string
  final String time;     // Formatted time string
  final String language; // Selected app language

  const OurTripScreen({
    super.key,
    required this.modeTitle,
    required this.icons,
    required this.price,
    required this.time,
    this.language = "English",
  });

  // --- Translation Helper ---
  // Returns text based on the current language selection
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Layer: Map image with dynamic path overlays
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset('assets/map.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                _buildDynamicColoredPaths(),
              ],
            ),
          ),

          // Top Layer: Cancel Trip button positioned at the top-right
          Positioned(
            top: 50,
            right: 20,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                  _t("سفر ختم کریں", "Trip Cancel Karein", "Cancel Trip"),
                  style: const TextStyle(color: Colors.white)
              ),
            ),
          ),

          // Sidebar: Floating action alerts (Location, Warnings, Traffic)
          Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.3,
              child: _buildSideAlerts()
          ),

          // Bottom Panel: Detailed Trip Information and Completion Action
          Positioned(
              bottom: 30,
              left: 15,
              right: 15,
              child: _buildBottomTripPanel(context)
          ),
        ],
      ),
    );
  }

  /// Builds a visual representation of the route using colored lines and pins
  Widget _buildDynamicColoredPaths() {
    String raw = icons.toLowerCase();

    // Detection logic for different transport modes
    bool isBike = icons.contains("🏍️") || raw.contains("bike") || raw.contains("بائیک") || raw.contains("موٹر");
    bool isCar = icons.contains("🚗") || raw.contains("car") || raw.contains("کار");
    bool hasWalk = icons.contains("🚶") || raw.contains("walk") || raw.contains("پیدل");
    bool hasPublic = icons.contains("🚇") || icons.contains("🚆") || icons.contains("🚌") || raw.contains("metro") || raw.contains("bus");
    bool hasPrivate = isBike || isCar;
    bool hasFinal = icons.contains("🛺") || icons.contains("🚕") || raw.contains("rickshaw") || raw.contains("رکشہ");

    // Line color logic: Blue for private, Red for public/default
    final Color lineCol = hasPrivate ? Colors.blueAccent : Colors.red;

    return Stack(
      children: [
        // Start Location Pin (Source)
        Positioned(top: 100, left: 30, child: const Icon(Icons.location_on, color: Colors.red, size: 50)),
        Positioned(top: 140, left: 50, child: _buildCornerPin()),

        // Optional Walking Path (Yellow)
        if (hasWalk) ...[
          Positioned(top: 150, left: 52, child: Container(width: 6, height: 100, color: Colors.yellowAccent)),
          Positioned(top: 245, left: 50, child: _buildCornerPin()),
          Positioned(top: 180, left: 45, child: const Text("🚶", style: TextStyle(fontSize: 22))),
        ],

        // Main Transit Path (Blue/Red) between major pointers
        if (hasPublic || hasPrivate || !hasWalk) ...[
          Positioned(top: 250, left: 52, child: Container(width: 200, height: 6, color: lineCol)),
          Positioned(top: 247, left: 242, child: _buildCornerPin()),
          Positioned(top: 250, left: 246, child: Container(width: 6, height: 300, color: lineCol)),
          Positioned(top: 546, left: 242, child: _buildCornerPin()),

          // Mode-specific icon overlays on the path
          if (icons.contains("🚇") || raw.contains("metro")) Positioned(top: 400, left: 235, child: const Text("🚇", style: TextStyle(fontSize: 26))),
          if (isBike) Positioned(top: 235, left: 140, child: const Text("🏍️", style: TextStyle(fontSize: 28))),
          if (isCar) Positioned(top: 450, left: 235, child: const Text("🚗", style: TextStyle(fontSize: 28))),
        ],

        // Last Mile Connection (Green) to Final Destination
        if (hasFinal || hasPrivate) ...[
          Positioned(top: 550, left: 246, child: Container(width: 100, height: 6, color: Colors.greenAccent)),
          Positioned(top: 547, left: 342, child: _buildCornerPin()),
          if (isBike) Positioned(top: 540, left: 300, child: const Text("🏍️", style: TextStyle(fontSize: 26))),
          if (isCar) Positioned(top: 540, left: 300, child: const Text("🚗", style: TextStyle(fontSize: 26))),
          if (icons.contains("🛺") || raw.contains("rickshaw")) Positioned(top: 540, left: 300, child: const Text("🛺", style: TextStyle(fontSize: 26))),
          if (icons.contains("🚕") || raw.contains("taxi")) Positioned(top: 540, left: 300, child: const Text("🚕", style: TextStyle(fontSize: 26))),
        ],

        // Destination Location Pin
        Positioned(top: 535, left: 340, child: const Icon(Icons.location_on, color: Colors.black, size: 40)),
      ],
    );
  }

  /// Small visual indicator for path intersections
  Widget _buildCornerPin() => Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle));

  /// Floating side container for status and alert icons
  Widget _buildSideAlerts() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey[700]!.withOpacity(0.9), borderRadius: BorderRadius.circular(40)),
      child: const Column(children: [
        Icon(Icons.location_on, color: Colors.red, size: 30),
        SizedBox(height: 25),
        Icon(Icons.warning, color: Colors.yellow, size: 30),
        SizedBox(height: 25),
        Icon(Icons.local_fire_department, color: Colors.orange, size: 30),
      ]),
    );
  }

  /// Interactive panel displaying trip summary and completion button
  Widget _buildBottomTripPanel(BuildContext context) {
    String bottomIcon = "";
    String raw = icons.toLowerCase();

    // Determine which primary icon to display next to the trip summary
    if (isBikeIcon(icons)) bottomIcon = "🏍️";
    else if (isCarIcon(icons)) bottomIcon = "🚗";
    else if (icons.contains("🚇") || raw.contains("metro")) bottomIcon = "🚇";
    else if (icons.contains("🛺") || raw.contains("rickshaw")) bottomIcon = "🛺";
    else if (icons.contains("🚕") || raw.contains("taxi")) bottomIcon = "🚕";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[600]!.withOpacity(0.95),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mode Title Badge (Public/Private/etc)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Text(modeTitle, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Trip Summary Text
              Expanded(child: Text("$bottomIcon $icons", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
              // Price and Estimated Arrival Time
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(price, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ]),
            ],
          ),
          const SizedBox(height: 15),

          // Complete Trip Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () {
                // Navigate to completion screen and pass trip data
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripCompletionScreen(
                          price: price,
                          time: time,
                          language: language,
                        )
                    )
                );
              },
              child: Text(
                  _t("سفر مکمل", "Trip Mukammal", "TRIP COMPLETE"),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Detects if the input string refers to a Bike mode
  bool isBikeIcon(String input) {
    String raw = input.toLowerCase();
    return input.contains("🏍️") || raw.contains("bike") || raw.contains("بائیک") || raw.contains("موٹر");
  }

  /// Helper: Detects if the input string refers to a Car mode
  bool isCarIcon(String input) {
    String raw = input.toLowerCase();
    return input.contains("🚗") || raw.contains("car") || raw.contains("کار");
  }
}