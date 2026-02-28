import 'package:flutter/material.dart';

class DriverDashboard extends StatefulWidget {
  final String language;
  const DriverDashboard({super.key, required this.language});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      // Side Menu (Drawer) jahan Profile aur History hogi
      drawer: const Drawer(),
      body: Stack(
        children: [
          // 1. MAP SECTION (Placeholder)
          Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Icon(Icons.map_outlined, size: 100, color: Colors.grey),
            ),
          ),

          // 2. TOP STATS BAR (Earnings & Rating)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopStat(isUrdu ? "آج کی کمائی" : "Today's Earn", "Rs. 1,250", Icons.account_balance_wallet),
                  _buildTopStat(isUrdu ? "ریٹنگ" : "Rating", "4.9 ★", Icons.star),
                ],
              ),
            ),
          ),

          // 3. BOTTOM CONTROL PANEL
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status Text
                  Text(
                    isOnline
                        ? (isUrdu ? "آپ آن لائن ہیں" : "YOU ARE ONLINE")
                        : (isUrdu ? "آپ آف لائن ہیں" : "YOU ARE OFFLINE"),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isOnline
                        ? (isUrdu ? "سواری کا انتظار ہے..." : "Waiting for requests...")
                        : (isUrdu ? "ڈیوٹی شروع کرنے کے لیے بٹن دبائیں" : "Go online to start earning"),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 25),

                  // Big Toggle Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isOnline = !isOnline;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.red : Colors.green,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isOnline ? Colors.red : Colors.green).withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Icon(
                        isOnline ? Icons.power_settings_new : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isOnline
                        ? (isUrdu ? "بند کریں" : "GO OFFLINE")
                        : (isUrdu ? "شروع کریں" : "GO ONLINE"),
                    style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stat Cards banane ke liye helper widget
  Widget _buildTopStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}