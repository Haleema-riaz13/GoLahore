import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'trip_completion_screen.dart';

class OurTripScreen extends StatelessWidget {
  final String modeTitle;
  final String icons;
  final String price;
  final String time;
  final String language;

  const OurTripScreen({
    super.key,
    required this.modeTitle,
    required this.icons,
    required this.price,
    required this.time,
    this.language = "English",
  });

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
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset('assets/map.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                _buildDynamicColoredPaths(),
              ],
            ),
          ),

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

          Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.3,
              child: _buildSideAlerts()
          ),

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

  Widget _buildDynamicColoredPaths() {
    String raw = icons.toLowerCase();

    bool isBike = icons.contains("🏍️") || raw.contains("bike");
    bool isCar = icons.contains("🚗") || raw.contains("car");
    bool hasWalk = icons.contains("🚶") || raw.contains("walk");
    bool hasPublic = icons.contains("🚆") || icons.contains("🚌") || icons.contains("🚇") || raw.contains("metro") || raw.contains("bus");
    bool hasRickshaw = icons.contains("🛺") || raw.contains("rickshaw");

    // In Hybrid/Public, line is mostly red (Public) or blue (Private)
    final Color lineCol = (isBike || isCar) ? Colors.blueAccent : Colors.red;

    return Stack(
      children: [
        Positioned(top: 100, left: 30, child: const Icon(Icons.location_on, color: Colors.red, size: 50)),
        Positioned(top: 140, left: 50, child: _buildCornerPin()),

        // Optional Walking or Initial Leg
        if (hasWalk) ...[
          Positioned(top: 150, left: 52, child: Container(width: 6, height: 100, color: Colors.yellowAccent)),
          Positioned(top: 245, left: 50, child: _buildCornerPin()),
          Positioned(top: 180, left: 45, child: const Text("🚶", style: TextStyle(fontSize: 22))),
        ],

        // Main Transit Leg (Public or Hybrid First Part)
        Positioned(top: 250, left: 52, child: Container(width: 200, height: 6, color: lineCol)),
        Positioned(top: 247, left: 242, child: _buildCornerPin()),
        Positioned(top: 250, left: 246, child: Container(width: 6, height: 300, color: lineCol)),
        Positioned(top: 546, left: 242, child: _buildCornerPin()),

        // Placing icons on path based on input
        if (hasPublic) Positioned(top: 400, left: 235, child: Text(icons.contains("🚆") ? "🚆" : "🚌", style: const TextStyle(fontSize: 26))),
        if (isBike) Positioned(top: 235, left: 140, child: const Text("🏍️", style: TextStyle(fontSize: 28))),
        if (hasRickshaw) Positioned(top: 235, left: 140, child: const Text("🛺", style: TextStyle(fontSize: 28))),

        // Last Mile (Hybrid Second Part)
        Positioned(top: 550, left: 246, child: Container(width: 100, height: 6, color: Colors.greenAccent)),
        Positioned(top: 547, left: 342, child: _buildCornerPin()),

        // Show the secondary mode on the final leg
        if (icons.contains("+")) ...[
          Positioned(top: 540, left: 300, child: Text(icons.split("+").last.trim(), style: const TextStyle(fontSize: 26))),
        ],

        Positioned(top: 535, left: 340, child: const Icon(Icons.location_on, color: Colors.black, size: 40)),
      ],
    );
  }

  Widget _buildCornerPin() => Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle));

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

  Widget _buildBottomTripPanel(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Text(modeTitle, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(icons, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(price, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ]),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () {
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
}