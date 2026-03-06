import 'package:flutter/material.dart';

class RiderFoundScreen extends StatelessWidget {
  final String vehicleType;
  final String language;

  const RiderFoundScreen({super.key, required this.vehicleType, required this.language});

  @override
  Widget build(BuildContext context) {
    // Determine if the UI should display Urdu strings
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Background Layer: A map asset with reduced opacity to emphasize the foreground panel
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/map.jpg', fit: BoxFit.cover),
            ),
          ),

          // Bottom Rider Info Panel: Contains all driver and vehicle details
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status Row: Displays arrival time and localized status message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isUrdu ? "آپ کا ڈرائیور راستے میں ہے" : "Your driver is on the way",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const Text("3 min", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 30),

                  // Rider Profile Section: Displays driver name, rating, and vehicle plate
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white10,
                        child: Icon(Icons.person, color: Colors.white, size: 40),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Arslan Ahmed", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
                                const SizedBox(width: 4),
                                Text("4.8 ${isUrdu ? '(450 سفر)' : '(450 rides)'}", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Vehicle Number Plate Styling
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: const Color(0xFFFFD700), borderRadius: BorderRadius.circular(8)),
                            child: const Text("LEC-4592", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 5),
                          // Dynamic Vehicle Model naming based on vehicleType
                          Text(vehicleType == "Car" ? "White Corolla" : (vehicleType == "Bike" ? "Honda CD-70" : "Auto Rickshaw"),
                              style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Action Buttons: Quick triggers for communication
                  Row(
                    children: [
                      _actionBtn(Icons.message, isUrdu ? "پیغام" : "Message", Colors.white12, Colors.white),
                      const SizedBox(width: 15),
                      _actionBtn(Icons.call, isUrdu ? "کال کریں" : "Call", const Color(0xFF2ECC71), Colors.white),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Secondary Action: Allows the user to cancel the ride
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(isUrdu ? "سفر منسوخ کریں" : "Cancel Trip", style: const TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent communication buttons (Call/Message)
  Widget _actionBtn(IconData icon, String label, Color bg, Color iconCol) {
    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconCol),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(color: iconCol, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}