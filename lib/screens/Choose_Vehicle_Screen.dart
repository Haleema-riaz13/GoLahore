import 'package:flutter/material.dart';
import 'driver_dashboard.dart';

// =========================================================
// SCREEN 1: CHOOSE VEHICLE SCREEN
// =========================================================
class ChooseVehicleScreen extends StatefulWidget {
  final String language;
  const ChooseVehicleScreen({super.key, required this.language});

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    String title = widget.language == "Urdu" ? "اپنی گاڑی منتخب کریں" : "Choose your vehicle";
    String subtitle = widget.language == "Urdu" ? "سفر شروع کرنے کے لیے اپنی سواری ka انتخاب کریں" : "Select your ride to start the journey";

    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              widget.language == "Urdu" ? "بند کریں" : "Close",
              style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // DARK VISIBLE BACKGROUND
          Positioned.fill(
            child: Opacity(
              opacity: 0.25, // Increased visibility for dark mode
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),
          // Dark Gradient Overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.4), Colors.black],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 40),

                  _buildVehicleBox("Car", widget.language == "Urdu" ? "کار" : "Comfortable Car", Icons.directions_car, Colors.blue),
                  _buildVehicleBox("Motorcycle", widget.language == "Urdu" ? "موٹر سائیکل" : "Fast Bike", Icons.motorcycle, Colors.orange),
                  _buildVehicleBox("Rickshaw", widget.language == "Urdu" ? "رکشہ" : "Local Rickshaw", Icons.electric_rickshaw, Colors.green),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          if (isNavigating)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E), // Dark card
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(strokeWidth: 4, color: Colors.orangeAccent),
                      const SizedBox(height: 20),
                      Text(
                        widget.language == "Urdu" ? "تھوڑا انتظار کریں..." : "Setting up your ride...",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVehicleBox(String label, String sublabel, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: isNavigating ? null : () async {
          setState(() => isNavigating = true);
          await Future.delayed(const Duration(milliseconds: 1500));
          if (!mounted) return;
          setState(() => isNavigating = false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverRegistrationScreen(language: widget.language, vehicleType: label)));
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E), // Dark card
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(18)),
                child: Icon(icon, color: color, size: 35),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(sublabel, style: TextStyle(fontSize: 14, color: Colors.white60)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: color.withOpacity(0.8), size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// SCREEN 2: DRIVER REGISTRATION SCREEN
// =========================================================
class DriverRegistrationScreen extends StatefulWidget {
  final String language;
  final String vehicleType;
  const DriverRegistrationScreen({super.key, required this.language, required this.vehicleType});

  @override
  State<DriverRegistrationScreen> createState() => _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget _buildField(String label, IconData icon, String hint, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.orangeAccent),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildUpload(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent),
          const SizedBox(width: 15),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.cloud_upload, color: Colors.white54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(isUrdu ? "رجسٹریشن مکمل کریں" : "Driver Registration",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.orangeAccent,
                            child: CircleAvatar(radius: 52, backgroundColor: Color(0xFF1E1E1E), child: Icon(Icons.person, size: 60, color: Colors.white24)),
                          ),
                          Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.black, size: 20))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildField(isUrdu ? "پورا نام" : "Full Name", Icons.person, isUrdu ? "اپنا نام لکھیں" : "Enter full name"),
                    _buildField(isUrdu ? "فون نمبر" : "Phone Number", Icons.phone, "03xx xxxxxxx", isNumber: true),
                    _buildField(isUrdu ? "لائسنس نمبر" : "License Number", Icons.badge, "XYZ-12345"),
                    _buildUpload(isUrdu ? "شناختی کارڈ (CNIC)" : "CNIC Photo", Icons.assignment_ind),
                    _buildUpload(isUrdu ? "ڈرائیونگ لائسنس" : "Driving License", Icons.drive_eta),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleInformationScreen(language: widget.language, vehicleType: widget.vehicleType)));
                        },
                        child: Text(isUrdu ? "اگلا" : "NEXT", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// SCREEN 3: VEHICLE INFORMATION SCREEN
// =========================================================
class VehicleInformationScreen extends StatefulWidget {
  final String language;
  final String vehicleType;
  const VehicleInformationScreen({super.key, required this.language, required this.vehicleType});

  @override
  State<VehicleInformationScreen> createState() => _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {

  Widget _buildField(String label, String hint, IconData icon, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.orangeAccent),
            hintText: hint, hintStyle: const TextStyle(color: Colors.white38),
            filled: true, fillColor: Colors.white.withOpacity(0.08),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildUploadTile(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orangeAccent.withOpacity(0.3))),
      child: Row(children: [Icon(icon, color: Colors.orangeAccent), const SizedBox(width: 15), Text(label, style: const TextStyle(color: Colors.white)), const Spacer(), const Icon(Icons.add_a_photo_outlined, color: Colors.white54)]),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(isUrdu ? "گاڑی کی معلومات" : "Vehicle Information", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField(isUrdu ? "برانڈ" : "Vehicle Brand", "Toyota, Suzuki...", Icons.branding_watermark),
                  _buildField(isUrdu ? "ماڈل" : "Vehicle Model", "Corolla, CD-70...", Icons.model_training),
                  _buildField(isUrdu ? "رنگ" : "Vehicle Color", "White, Black...", Icons.color_lens),
                  _buildField(isUrdu ? "نمبر پلیٹ" : "Number Plate", "LEA-1234", Icons.pin),
                  _buildField(isUrdu ? "پیداوار کا سال" : "Production Year", "2024", Icons.calendar_today, isNumber: true),
                  _buildUploadTile(isUrdu ? "گاڑی کی تصویر" : "Photo of Vehicle", Icons.camera_alt),
                  _buildUploadTile(isUrdu ? "گاڑی کی رجسٹریشن" : "Vehicle Registration", Icons.file_present),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPendingScreen(language: widget.language)));
                      },
                      child: Text(isUrdu ? "جمع کرائیں" : "SUBMIT", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
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
}

// =========================================================
// SCREEN 4: REGISTRATION PENDING SCREEN (WITH TRIPLE TAP)
// =========================================================
class RegistrationPendingScreen extends StatefulWidget {
  final String language;
  const RegistrationPendingScreen({super.key, required this.language});

  @override
  State<RegistrationPendingScreen> createState() => _RegistrationPendingScreenState();
}

class _RegistrationPendingScreenState extends State<RegistrationPendingScreen> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void _handleTripleTap() {
    DateTime now = DateTime.now();
    if (_lastTapTime == null || now.difference(_lastTapTime!) > const Duration(milliseconds: 500)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTapTime = now;

    if (_tapCount == 3) {
      _tapCount = 0;
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DriverDashboard(language: widget.language),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _handleTripleTap,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Container(
                          height: 150, width: 150,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.15),
                              shape: BoxShape.circle
                          ),
                          child: const Icon(Icons.timer_outlined, size: 80, color: Colors.orangeAccent),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          isUrdu ? "درخواست موصول ہو گئی ہے" : "Application Received!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isUrdu
                        ? "آپ کی فراہم کردہ معلومات کی جانچ پڑتال کی جا رہی ہے۔ تصدیق مکمل ہونے پر آپ کو مطلع کر دیا جائے گا۔"
                        : "We are reviewing your documents. You will be notified once your account is activated (usually within 24-48 hours).",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.black),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            isUrdu ? "تصدیق کا عمل جاری ہے" : "Verification is in progress",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.white24)),
                      ),
                      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                      child: Text(
                        isUrdu ? "ہوم اسکرین پر واپس جائیں" : "BACK TO HOME",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
}