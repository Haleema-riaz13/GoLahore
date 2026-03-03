import 'package:flutter/material.dart';
import 'driver_dashboard.dart';

class RegistrationPendingScreen extends StatelessWidget {
  final String language;
  const RegistrationPendingScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    // Boolean check for Urdu language support
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Interactive Icon Section ---
              // Wrapped in GestureDetector with LongPress for internal testing/preview purposes
              GestureDetector(
                onLongPress: () {
                  // Direct navigation to DriverDashboard to bypass the wait during development
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DriverDashboard(language: language),
                    ),
                  );
                },
                child: Container(
                  height: 180, width: 180,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.05),
                      shape: BoxShape.circle
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Continuous loading indicator representing the "Review" phase
                      const SizedBox(
                        height: 140, width: 140,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const Icon(Icons.verified_user_outlined, size: 70, color: Colors.orangeAccent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // --- Success/Pending Title ---
              Text(
                isUrdu ? "درخواست موصول ہو گئی ہے" : "Application Received!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // --- Descriptive Guidance Text ---
              Text(
                isUrdu
                    ? "آپ کی فراہم کردہ معلومات کی جانچ پڑتال کی جا رہی ہے۔ تصدیق مکمل ہونے پر آپ کو مطلع کر دیا جائے گا۔"
                    : "Your documents are under review. Our team is verifying your details for the GoLahore fleet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.6),
              ),
              const SizedBox(height: 40),

              // --- Estimated Timeframe Banner ---
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_bottom_rounded, color: Colors.white),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        isUrdu ? "تصدیق کا عمل جاری ہے (24-48 گھنٹے)" : "Verification in progress (24-48h)",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // --- Primary Action Button: Reset stack to Home ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orangeAccent, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  child: Text(
                    isUrdu ? "ہوم اسکرین پر واپس جائیں" : "BACK TO HOME",
                    style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Hint text for developers/reviewers to navigate forward
              Text(
                isUrdu ? "(ڈیش بورڈ دیکھنے کے لیے آئیکن کو دبا کر رکھیں)" : "(Long press icon to preview dashboard)",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}