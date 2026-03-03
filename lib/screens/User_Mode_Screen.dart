import 'package:flutter/material.dart';
import '../utils/transitions.dart';
import 'welcome_screen.dart';
import 'choose_vehicle_screen.dart';

class UserModeScreen extends StatefulWidget {
  final String language;
  const UserModeScreen({super.key, required this.language});

  @override
  State<UserModeScreen> createState() => _UserModeScreenState();
}

class _UserModeScreenState extends State<UserModeScreen> {
  // Local state to track which mode is selected and the loading status
  String selectedMode = "";
  bool isLoading = false;

  // Function to handle the transition after clicking Continue
  void _handleContinue() async {
    setState(() => isLoading = true);

    // Simulating a network or processing delay for better UX
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => isLoading = false);

    // Navigation logic based on the selected role
    if (selectedMode == "Passenger") {
      Navigator.pushReplacement(context, createSmoothRoute(WelcomeScreen(language: widget.language)));
    } else {
      Navigator.push(context, createSmoothRoute(ChooseVehicleScreen(language: widget.language)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Localization logic for UI strings based on the passed language
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
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Subtle background image of a mosque at 15% opacity
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
                  // App Branding: Location Pin inside a bordered circle
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
                  Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15),
                  ),
                  const SizedBox(height: 50),

                  // Mode Selection Tiles
                  _buildModeTile(passengerTitle, passengerSub, Icons.directions_bus, "Passenger"),
                  _buildModeTile(driverTitle, driverSub, Icons.directions_car, "Driver"),

                  const Spacer(),

                  // Action Button: Disabled if no mode is selected
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
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16, letterSpacing: 1.2)
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

  // Helper widget to create a consistent look for the Passenger/Driver options
  Widget _buildModeTile(String title, String sub, IconData icon, String modeKey) {
    bool isSelected = selectedMode == modeKey;
    return GestureDetector(
      onTap: () => setState(() => selectedMode = modeKey),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // Logic: Highlight the tile if it is the currently selected one
          color: isSelected ? Colors.orangeAccent.withOpacity(0.12) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: isSelected ? Colors.orangeAccent : Colors.white.withOpacity(0.08),
              width: 2
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.orangeAccent : Colors.white70, size: 32),
            const SizedBox(width: 20),
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
            // Radio-style icon to show selection state visually
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.orangeAccent : Colors.white24,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}