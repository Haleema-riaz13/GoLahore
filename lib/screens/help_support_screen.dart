import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';

class HelpSupportScreen extends StatelessWidget {
  final String language; // Holds the current application language state

  const HelpSupportScreen({super.key, this.language = "English"});

  // --- Translation Helper Method ---
  // Selects the appropriate string based on the provided language parameter
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Navigation back to previous screen
        ),
        title: Text(
          _t("مدد اور سپورٹ", "Help & Support", "Help & Support"),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background Layer: Consistent mosque theme with low opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),

          // Content Layer: List of support services and helplines
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                _t("لاہور ایمرجنسی ہیلپ لائنز", "Lahore Emergency Helplines", "Lahore Emergency Helplines"),
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Emergency and Transport Helpline Tiles
              _buildHelpTile(_t("پولیس ایمرجنسی", "Police Emergency", "Police Emergency"), "15", Icons.local_police, Colors.blue),
              _buildHelpTile(_t("ریسکیو / ایمبولینس", "Rescue / Ambulance", "Rescue / Ambulance"), "1122", Icons.medical_services, Colors.red),
              _buildHelpTile(_t("اورنج لائن میٹرو", "Orange Line Metro", "Orange Line Metro"), "042-111-222-627", Icons.train, Colors.orange),
              _buildHelpTile(_t("میٹرو بس ہیلپ لائن", "Metro Bus Helpline", "Metro Bus Helpline"), "042-111-222-627", Icons.directions_bus, Colors.green),
              _buildHelpTile(_t("لاہور ٹریفک پولیس", "Lahore Traffic Police", "Lahore Traffic Police"), "1915", Icons.traffic, Colors.blueAccent),
              _buildHelpTile(_t("ایدھی ایمبولینس", "Edhi Ambulance", "Edhi Ambulance"), "115", Icons.health_and_safety, Colors.redAccent),
              _buildHelpTile(_t("موٹروے پولیس", "Motorway Police", "Motorway Police"), "130", Icons.add_road, Colors.grey),
              _buildHelpTile(_t("واپڈا (بجلی)", "WAPDA (Electricity)", "WAPDA (Electricity)"), "118", Icons.electric_bolt, Colors.yellow),

              const SizedBox(height: 30),
              const Divider(color: Colors.white10),
              const SizedBox(height: 10),

              // App Specific Support Section
              Text(
                _t("ایپ سپورٹ سے رابطہ کریں", "Contact App Support", "Contact App Support"),
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),

              _buildHelpTile(_t("ہمیں ای میل کریں", "Email Karein", "Email Us"), "support@lahoretransit.com", Icons.email, Colors.teal),
              _buildHelpTile(_t("ایپ کی خرابی رپورٹ کریں", "App Bug report karein", "Report an App Bug"), _t("رائے جمع کروائیں", "Feedback dein", "Submit Feedback"), Icons.bug_report, Colors.purpleAccent),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent helpline and support list tiles
  Widget _buildHelpTile(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        trailing: const Icon(Icons.call, color: Colors.green, size: 20),
        onTap: () {
          // Placeholder for phone dialer or email intent logic
        },
      ),
    );
  }
}