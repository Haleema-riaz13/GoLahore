import 'package:flutter/material.dart';
import '../utils/transitions.dart';
import 'welcome_screen.dart';
import 'choose_vehicle_screen.dart';
import 'private_transport_booking_screen.dart'; // Import for the passenger booking flow

class UserModeScreen extends StatefulWidget {
  final String language;
  const UserModeScreen({super.key, required this.language});

  @override
  State<UserModeScreen> createState() => _UserModeScreenState();
}

class _UserModeScreenState extends State<UserModeScreen> {
  // Variable to store the currently selected role (Passenger or Driver)
  String selectedMode = "";
  // State to manage loading indicator visibility
  bool isLoading = false;

  // Handles the screen transition and simulated delay when clicking Continue
  void _handleContinue() async {
    setState(() => isLoading = true);

    // Simulated processing time for a smoother user experience
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => isLoading = false);

    // Navigation logic: Redirects to booking screen if Passenger, or vehicle selection if Driver
    if (selectedMode == "Passenger") {
      Navigator.pushReplacement(
          context,
          createSmoothRoute(PrivateTransportBookingScreen(language: widget.language))
      );
    } else {
      Navigator.push(
          context,
          createSmoothRoute(ChooseVehicleScreen(language: widget.language))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Localization strings determined by the language passed in the constructor
    String title = widget.language == "Urdu" ? "اپنا کردار منتخب کریں" : "Choose Your Role";
    String subtitle = widget.language == "Urdu"
        ? "آپ گو لاہور کو کیسے استعمال کرنا چاہیں گے؟"
        : "How would you like to use GoLahore?";
    String passengerTitle = widget.language == "Urdu" ? "مسافر" : "Passenger";
    String passengerSub = widget.language == "Urdu" ? "میں راستے تلاش کر کے سفر کرنا چاہتا ہوں" : "I want to find routes & travel";
    String driverTitle = widget.language == "Urdu" ? "ڈرائیور" : "Driver";
    String driverSub = widget.language == "Urdu" ? "میں ٹرانسپورٹ کی خدمات فراہم کرنا چاہتا ہوں" : "I want to provide transport services";
    String continueBtn = widget.language == "Urdu" ? "آگے بڑھیں" : "CONTINUE";

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Deep dark background theme
      body: Stack(
        children: [
          // Background Layer: Mosque watermark with low opacity
          Positioned.fill(
              child: Opacity(
                  opacity: 0.15,
                  child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)
              )
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Branding: Location icon inside a bordered circular container
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.8), width: 2)
                    ),
                    child: const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.orangeAccent,
                        child: Icon(Icons.location_on, color: Colors.white, size: 45)
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Screen Title
                  Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  // Screen Subtitle
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15),
                  ),
                  const SizedBox(height: 50),

                  // Role Selection Options
                  _buildModeTile(passengerTitle, passengerSub, Icons.directions_bus, "Passenger"),
                  _buildModeTile(driverTitle, driverSub, Icons.directions_car, "Driver"),

                  const Spacer(), // Pushes the action button to the bottom

                  // Continue Button: Only enabled when a mode is selected and not loading
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMode != "" ? Colors.orangeAccent : Colors.grey.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      onPressed: (selectedMode != "" && !isLoading) ? _handleContinue : null,
                      child: isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text(
                          continueBtn,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16, letterSpacing: 1.2)
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable helper widget to build role selection tiles
  Widget _buildModeTile(String title, String sub, IconData icon, String modeKey) {
    // Check if this specific tile is currently selected
    bool isSelected = selectedMode == modeKey;

    return GestureDetector(
      onTap: () => setState(() => selectedMode = modeKey),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        decoration: BoxDecoration(
          // Change appearance based on selection state
          color: isSelected ? Colors.white.withOpacity(0.1) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: isSelected ? Colors.orangeAccent : Colors.white.withOpacity(0.08),
              width: 2
          ),
        ),
        child: Row(
          children: [
            // Role Icon inside an orange circular background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.black, size: 28),
            ),
            const SizedBox(width: 20),
            // Title and description column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)
                  ),
                  const SizedBox(height: 4),
                  Text(
                      sub,
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)
                  ),
                ],
              ),
            ),
            // Custom Radio Button indicator
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.orangeAccent : Colors.white24,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}