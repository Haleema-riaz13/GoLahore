import 'package:flutter/material.dart';

// --- MAIN BOOKING SCREEN ---
class PrivateTransportBookingScreen extends StatefulWidget {
  final String language;

  const PrivateTransportBookingScreen({super.key, this.language = "English"});

  @override
  State<PrivateTransportBookingScreen> createState() => _PrivateTransportBookingScreenState();
}

class _PrivateTransportBookingScreenState extends State<PrivateTransportBookingScreen> {
  String selectedVehicle = "Car";
  bool isSearching = false;
  bool hasSearched = false;

  // State management for payment methods and promo codes
  String selectedPaymentMethod = "Cash";
  final TextEditingController _promoController = TextEditingController();

  // Controllers for pickup and destination text fields
  final TextEditingController _sourceController = TextEditingController(text: "My Current Location");
  final TextEditingController _destController = TextEditingController();

  // Boolean to determine if the ride selection panel should be visible
  bool get _showRides => hasSearched && !isSearching && _destController.text.isNotEmpty;

  // Handles the search execution with a simulated loading delay
  void _executeSearch() async {
    if (_destController.text.isEmpty) return;

    // Hide the keyboard when search starts
    FocusScope.of(context).unfocus();

    setState(() {
      isSearching = true;
      hasSearched = false;
    });

    // Simulated network delay for route calculation
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        isSearching = false;
        hasSearched = true;
      });
    }
  }

  // Opens a dialog for user to enter a promo code
  void _showPromoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          widget.language == "Urdu" ? "پروومو کوڈ درج کریں" : "Enter Promo Code",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        content: TextField(
          controller: _promoController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "GO-LAHORE-50",
            hintStyle: TextStyle(color: Colors.white24),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white54))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Promo Applied!"))
              );
            },
            child: const Text("Apply", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // Opens a bottom sheet to select between Cash, JazzCash, and EasyPaisa
  void _showPaymentSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _paymentTile("Cash", Icons.payments_outlined, Colors.green),
          _paymentTile("JazzCash", Icons.account_balance_wallet, const Color(0xFFD42027)),
          _paymentTile("EasyPaisa", Icons.phonelink_ring, const Color(0xFF1CB14B)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper widget for payment method list items
  Widget _paymentTile(String method, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: color),
      ),
      title: Text(method, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      trailing: selectedPaymentMethod == method ? const Icon(Icons.check_circle, color: Colors.orangeAccent) : null,
      onTap: () {
        setState(() => selectedPaymentMethod = method);
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _destController.dispose();
    _sourceController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Background Layer: Static Map Image
          Positioned.fill(
            child: Container(
              color: Colors.grey[900],
              child: Stack(
                children: [
                  Image.asset('assets/map.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                  const Center(child: Icon(Icons.location_on, color: Colors.redAccent, size: 45)),
                ],
              ),
            ),
          ),

          // Top UI Layer: Search Bar and Back Button
          Positioned(
            top: 50, left: 15, right: 15,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10)]),
                  child: Column(
                    children: [
                      _buildSearchField(_sourceController, isUrdu ? "کہاں سے؟" : "Pickup Location", Icons.my_location, Colors.greenAccent),
                      const Padding(padding: EdgeInsets.only(left: 35), child: Divider(color: Colors.white10, height: 20)),
                      Row(
                        children: [
                          Expanded(child: _buildSearchField(_destController, isUrdu ? "کہاں جانا hai؟" : "Where to?", Icons.location_on, Colors.redAccent)),
                          IconButton(icon: const Icon(Icons.search, color: Color(0xFFFFD700), size: 28), onPressed: _executeSearch),
                        ],
                      ),
                      // Linear progress bar visible during search state
                      if (isSearching) const Padding(padding: EdgeInsets.only(top: 15), child: LinearProgressIndicator(color: Color(0xFFFFD700), backgroundColor: Colors.white10)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Draggable Panel: Ride Options (Visible after search)
          if (_showRides)
            DraggableScrollableSheet(
              initialChildSize: 0.45, minChildSize: 0.45, maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)), boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)]),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(height: 20),
                      Text(isUrdu ? "دستیاب سواریاں" : "Available Rides", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      _buildVehicleOption("Bike", isUrdu ? "بائیک (تیز رفتار)" : "Bike (Fast)", "Rs. 180", Icons.directions_bike),
                      _buildVehicleOption("Rickshaw", isUrdu ? "رکشہ (مناسب)" : "Rickshaw (Eco)", "Rs. 320", Icons.electric_rickshaw),
                      _buildVehicleOption("Car", isUrdu ? "کار (آرام دہ)" : "Car (AC Comfort)", "Rs. 550", Icons.directions_car),
                      const Divider(color: Colors.white10),

                      // Interactive row for Payment Method and Promo Code
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _showPaymentSelection,
                              child: Row(
                                children: [
                                  const Icon(Icons.payments_outlined, color: Colors.greenAccent, size: 20),
                                  const SizedBox(width: 10),
                                  Text(selectedPaymentMethod, style: const TextStyle(color: Colors.white70)),
                                  const Icon(Icons.arrow_drop_down, color: Colors.white54),
                                ],
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _showPromoDialog,
                              child: Row(
                                children: [
                                  const Icon(Icons.local_offer, color: Colors.orangeAccent, size: 16),
                                  const SizedBox(width: 5),
                                  Text(isUrdu ? "پروومو" : "Promo", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Final Call to Action Button
                      SizedBox(
                        width: double.infinity, height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () => _searchingRiderSheet(),
                          child: Text(isUrdu ? "ابھی بک کریں" : "BOOK NOW", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // Custom text field widget for pickup and destination inputs
  Widget _buildSearchField(TextEditingController controller, String hint, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(controller: controller, onSubmitted: (_) => _executeSearch(), style: const TextStyle(color: Colors.white, fontSize: 15), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white24), border: InputBorder.none)),
        ),
      ],
    );
  }

  // Selectable vehicle card widget
  Widget _buildVehicleOption(String key, String title, String price, IconData icon) {
    bool isSelected = selectedVehicle == key;
    return GestureDetector(
      onTap: () => setState(() => selectedVehicle = key),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: isSelected ? Colors.white.withOpacity(0.05) : Colors.transparent, borderRadius: BorderRadius.circular(15), border: Border.all(color: isSelected ? const Color(0xFFFFD700) : Colors.white10, width: 1.5)),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isSelected ? const Color(0xFFFFD700) : Colors.white10, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: isSelected ? Colors.black : Colors.white, size: 24)),
            const SizedBox(width: 15),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Text("1-3 min away", style: TextStyle(color: Colors.white38, fontSize: 11))])),
            Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Shows a modal bottom sheet to simulate searching for a driver nearby
  void _searchingRiderSheet() {
    showModalBottomSheet(
      context: context, backgroundColor: const Color(0xFF1E1E1E), isDismissible: false, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => RiderFoundScreen(vehicleType: selectedVehicle, language: widget.language)));
          }
        });
        return Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50, width: 50, child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 4)),
              const SizedBox(height: 25),
              Text(widget.language == "Urdu" ? "ڈرائیور کی تلاش جاری ہے..." : "Finding your driver...", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextButton(onPressed: () => Navigator.pop(context), child: Text(widget.language == "Urdu" ? "کینسل" : "Cancel", style: const TextStyle(color: Colors.redAccent)))
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
          // Background Map with opacity
          Positioned.fill(child: Opacity(opacity: 0.5, child: Image.asset('assets/map.jpg', fit: BoxFit.cover))),
          // Back button to return to booking
          Positioned(top: 50, left: 20, child: CircleAvatar(backgroundColor: Colors.black54, child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)))),
          // Bottom Card: Driver and Vehicle Details
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)), boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isUrdu ? "آپ کا ڈرائیور راستے میں hai" : "Your driver is on the way", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      const Text("3 min", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 30),
                  Row(
                    children: [
                      const CircleAvatar(radius: 30, backgroundColor: Colors.white10, child: Icon(Icons.person, color: Colors.white, size: 40)),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Arslan Ahmed", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            Row(children: [const Icon(Icons.star, color: Color(0xFFFFD700), size: 16), const SizedBox(width: 4), Text("4.8 ${isUrdu ? '(450 سفر)' : '(450 rides)'}", style: const TextStyle(color: Colors.white38, fontSize: 12))]),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Car License Plate
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFFD700), borderRadius: BorderRadius.circular(8)), child: const Text("LEC-4592", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                          const SizedBox(height: 5),
                          // Dynamic Vehicle Model Text
                          Text(vehicleType == "Car" ? "White Corolla" : (vehicleType == "Bike" ? "Honda CD-70" : "Auto Rickshaw"), style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Action Buttons: Messaging and Calling the Driver
                  Row(
                    children: [
                      _actionBtn(Icons.message, isUrdu ? "پیغام" : "Message", Colors.white12, Colors.white),
                      const SizedBox(width: 15),
                      _actionBtn(Icons.call, isUrdu ? "کال کریں" : "Call", const Color(0xFF2ECC71), Colors.white),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Emergency Cancel Option
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(isUrdu ? "سفر منسوخ کریں" : "Cancel Trip", style: const TextStyle(color: Colors.redAccent))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable button widget for driver communication actions
  Widget _actionBtn(IconData icon, String label, Color bg, Color iconCol) {
    return Expanded(child: Container(height: 55, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: iconCol), const SizedBox(width: 10), Text(label, style: TextStyle(color: iconCol, fontWeight: FontWeight.bold))])));
  }
}