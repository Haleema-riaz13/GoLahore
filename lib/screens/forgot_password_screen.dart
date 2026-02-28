import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String language;
  const ForgotPasswordScreen({super.key, this.language = "English"});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // State to manage password visibility toggle
  bool _isPasswordHidden = true;

  // Controllers to track text changes
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Function to check if both fields are filled
  bool get _isFormValid => _emailController.text.isNotEmpty && _passController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Re-build UI when text changes to update button state
    _emailController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Translation Logic ---
    String title = "RESET PASSWORD";
    String emailHint = "Email or phone";
    String newPassHint = "New Password";
    String confirmBtn = "RESET PASSWORD";
    String backToLogin = "Back to Login";

    if (widget.language == "Urdu") {
      title = "پاس ورڈ دوبارہ ترتیب دیں";
      emailHint = "ای میل یا فون نمبر";
      newPassHint = "نیا پاس ورڈ";
      confirmBtn = "پاس ورڈ تبدیل کریں";
      backToLogin = "لاگ ان پر واپس جائیں";
    }
    else if (widget.language == "Roman Urdu") {
      title = "RESET PASSWORD";
      emailHint = "Email ya phone";
      newPassHint = "Naya Password";
      confirmBtn = "RESET KAREIN";
      backToLogin = "Login par wapis jayein";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
          )
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)),
          const GradientOverlay(color: Colors.black, opacity: 0.4, endOpacity: 0.85),

          SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Text(
                                title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)
                            ),
                            const SizedBox(height: 50),

                            // Added Controllers to fields
                            GlassWrapper(child: _buildField(Icons.person_outline, emailHint, _emailController)),
                            const SizedBox(height: 20),
                            GlassWrapper(child: _buildPasswordField(newPassHint, _passController)),

                            const SizedBox(height: 40),

                            // UPDATED: RESET PASSWORD Button with validation logic
                            GestureDetector(
                              onTap: _isFormValid ? () {
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(widget.language == "Urdu" ? "پاس ورڈ تبدیل کر دیا گیا ہے" : "Password reset successful!"))
                                );
                                Navigator.pop(context);
                              } : null, // Disables click if form is not valid
                              child: Opacity(
                                opacity: _isFormValid ? 1.0 : 0.5, // Faded if not clickable
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    confirmBtn,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Navigator.pop(context);
                              },
                              child: Text(backToLogin, style: const TextStyle(color: Colors.white70)),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  // Updated with controller
  Widget _buildField(IconData icon, String hint, TextEditingController controller) {
    return TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white70),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15)
        )
    );
  }

  // Updated with controller
  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return TextField(
        controller: controller,
        obscureText: _isPasswordHidden,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_reset, color: Colors.white70),
            suffixIcon: IconButton(
                icon: Icon(_isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white70),
                onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden)
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15)
        )
    );
  }
}