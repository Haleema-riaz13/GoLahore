import 'package:flutter/material.dart';

// --- MAIN BOOKING SCREEN ---
class PrivateTransportBookingScreen extends StatefulWidget {
  final String language;

  const PrivateTransportBookingScreen({super.key, this.language = "English"});

  @override
  State<PrivateTransportBookingScreen> createState() => _PrivateTransportBookingScreenState();
}

class _PrivateTransportBookingScreenState extends State<PrivateTransportBookingScreen> {
  String selectedVehicle = "Car"; // Default selection

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // 1. Map Section (Background)
          Positioned.fill(
            bottom: 300,
            child: Container(
              color: Colors.grey[900],
              child: Stack(
                children: [
                  Image.asset(
                    'assets/map.jpg', // Make sure this asset exists
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Colors.redAccent, size: 45),
                        Card(
                          color: Colors.black87,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text("Pick-up Location", style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Back Button
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. Bottom Booking Panel
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 380,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isUrdu ? "اپنی سواری منتخب کریں" : "Select Your Ride",
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  Expanded(
                    child: ListView(
                      children: [
                        _buildVehicleOption("Bike", isUrdu ? "بائیک (تیز رفتار)" : "Bike (Fast)", "Rs. 180", Icons.directions_bike),
                        _buildVehicleOption("Rickshaw", isUrdu ? "رکشہ (مناسب)" : "Rickshaw (Eco)", "Rs. 320", Icons.electric_rickshaw),
                        _buildVehicleOption("Car", isUrdu ? "کار (آرام دہ)" : "Car (AC Comfort)", "Rs. 550", Icons.directions_car),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.white10),
                  Row(
                    children: [
                      const Icon(Icons.payment, color: Colors.greenAccent),
                      const SizedBox(width: 10),
                      Text(isUrdu ? "نقد (کیش)" : "Cash", style: const TextStyle(color: Colors.white70)),
                      const Spacer(),
                      const Icon(Icons.local_offer, color: Colors.orangeAccent, size: 20),
                      const SizedBox(width: 5),
                      Text(isUrdu ? "پروومو کوڈ" : "Promo", style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () => _searchingRiderSheet(),
                      child: Text(
                        isUrdu ? "رائڈ بک کریں" : "REQUEST RIDE",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOption(String key, String title, String price, IconData icon) {
    bool isSelected = selectedVehicle == key;
    return GestureDetector(
      onTap: () => setState(() => selectedVehicle = key),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFD700) : Colors.white12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: isSelected ? const Color(0xFFFFD700) : Colors.white10, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: isSelected ? Colors.black : Colors.white, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text("2 mins away", style: TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
            Text(price, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _searchingRiderSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      isDismissible: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pop(context); // Close searching sheet
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiderFoundScreen(
                vehicleType: selectedVehicle,
                language: widget.language,
              )),
            );
          }
        });

        return Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 60, width: 60, child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 5)),
              const SizedBox(height: 30),
              Text(
                widget.language == "Urdu" ? "آپ کے لیے سوار تلاش کر رہے ہیں..." : "Finding your driver...",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Please wait a moment", style: TextStyle(color: Colors.white38)),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(widget.language == "Urdu" ? "کینسل کریں" : "Cancel Request", style: const TextStyle(color: Colors.redAccent)),
              )
            ],
          ),
        );
      },
    );
  }
}

// --- RIDER DETAILS SCREEN ---
class RiderFoundScreen extends StatelessWidget {
  final String vehicleType;
  final String language;

  const RiderFoundScreen({super.key, required this.vehicleType, required this.language});

  @override
  Widget build(BuildContext context) {
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/map.jpg', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: const Color(0xFFFFD700), borderRadius: BorderRadius.circular(8)),
                            child: const Text("LEC-4592", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            vehicleType == "Car" ? "White Corolla" : (vehicleType == "Bike" ? "Honda CD-70" : "Auto Rickshaw"),
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      _actionBtn(Icons.message, isUrdu ? "پیغام" : "Message", Colors.white12, Colors.white),
                      const SizedBox(width: 15),
                      _actionBtn(Icons.call, isUrdu ? "کال کریں" : "Call", const Color(0xFF2ECC71), Colors.white),
                    ],
                  ),
                  const SizedBox(height: 15),
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