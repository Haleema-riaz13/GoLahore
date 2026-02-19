import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';

class CommunityReportScreen extends StatefulWidget {
  final String language; // Holds the selected language state (Urdu, Roman Urdu, or English)

  const CommunityReportScreen({super.key, this.language = "English"});

  @override
  State<CommunityReportScreen> createState() => _CommunityReportScreenState();
}

class _CommunityReportScreenState extends State<CommunityReportScreen> {
  // Stores the currently selected reporting category
  String selectedIssue = "";

  // --- Translation Helper Method ---
  // Returns the appropriate string based on the current language parameter
  String _t(String ur, String ro, String en) {
    if (widget.language == "Urdu") return ur;
    if (widget.language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic labels initialized based on the selected language
    String mainTitle = _t("کمیونٹی\nرپورٹس", "Community\nReports", "Community\nReports");
    String submitBtn = _t("جمع کریں", "Submit", "Submit");
    String appTitle = _t("کمیونٹی رپورٹ", "Community Report", "Community Report");

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(appTitle, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
      body: Stack(
        children: [
          // Background Layer: Themed image with low opacity for better readability
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/mosque.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content Layer: Centralized reporting panel
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mainTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // List of interactive reporting options
                  _buildReportOption(_t("⚠️ راستہ بند ہے", "⚠️ RoadBlock", "⚠️ RoadBlock")),
                  _buildReportOption(_t("🚗 ٹریفک جام", "🚗 Traffic jam", "🚗 Traffic jam")),
                  _buildReportOption(_t("☁️ خراب موسم", "☁️ Bad weather", "☁️ Bad weather")),
                  _buildReportOption(_t("⚙️ سروس کا مسئلہ", "⚙️ Service issue", "⚙️ Service issue")),
                  _buildReportOption(_t("📍 نیا بس سٹاپ", "📍 New bus stop", "📍 New bus stop")),

                  const SizedBox(height: 30),

                  // Submission Button Logic
                  GestureDetector(
                    onTap: () {
                      if (selectedIssue.isNotEmpty) {
                        // Display success confirmation via SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(_t("$selectedIssue رپورٹ جمع ہوگئی!", "$selectedIssue report ho gayi!", "$selectedIssue reported successfully!"))),
                        );
                        // Navigate back to the previous screen upon successful submission
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B85B8),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_circle_right_outlined, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            submitBtn,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
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

  /// Helper widget to build individual report category buttons
  Widget _buildReportOption(String label) {
    bool isSelected = selectedIssue == label;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => selectedIssue = label), // Update UI on selection
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white24 : Colors.white10,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.white24,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}