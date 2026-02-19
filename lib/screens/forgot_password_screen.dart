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

  @override
  Widget build(BuildContext context) {
    // --- Translation Logic ---
    // Default English strings
    String title = "RESET PASSWORD";
    String emailHint = "Email or phone";
    String newPassHint = "New Password";
    String confirmBtn = "RESET PASSWORD";
    String backToLogin = "Back to Login";

    // Urdu translations
    if (widget.language == "Urdu") {
      title = "پاس ورڈ دوبارہ ترتیب دیں";
      emailHint = "ای میل یا فون نمبر";
      newPassHint = "نیا پاس ورڈ";
      confirmBtn = "پاس ورڈ تبدیل کریں";
      backToLogin = "لاگ ان پر واپس جائیں";
    }
    // Roman Urdu translations
    else if (widget.language == "Roman Urdu") {
      title = "RESET PASSWORD";
      emailHint = "Email ya phone";
      newPassHint = "Naya Password";
      confirmBtn = "RESET KAREIN";
      backToLogin = "Login par wapis jayein";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Automatically adjust layout when the keyboard appears to prevent overflows
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                // Dismiss keyboard before navigating back
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
          )
      ),
      body: Stack(
        children: [
          // Background Layer: Themed image
          Positioned.fill(child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)),
          // Gradient Overlay: Ensures text remains readable over the background
          const GradientOverlay(color: Colors.black, opacity: 0.4, endOpacity: 0.85),

          SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ConstrainedBox(
                      // Ensures the content takes at least the full height of the screen
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

                            // Input Fields with Glassmorphism effect
                            GlassWrapper(child: _buildField(Icons.person_outline, emailHint)),
                            const SizedBox(height: 20),
                            GlassWrapper(child: _buildPasswordField(newPassHint)),

                            const SizedBox(height: 40),

                            // Action Button: Triggers password reset logic
                            PrimaryActionButton(
                              label: confirmBtn,
                              onTap: () {
                                // Dismiss keyboard on action
                                FocusScope.of(context).unfocus();

                                // Visual feedback for user
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(widget.language == "Urdu" ? "پاس ورڈ تبدیل کر دیا گیا ہے" : "Password reset successful!"))
                                );
                                Navigator.pop(context);
                              },
                            ),

                            // Pushes the footer to the bottom of the screen
                            const Spacer(),

                            // Navigation back to login
                            TextButton(
                              onPressed: () {
                                // Dismiss keyboard before navigating back
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

  /// Helper to build standard text input fields
  Widget _buildField(IconData icon, String hint) {
    return TextField(
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

  /// Helper to build password input fields with visibility toggle
  Widget _buildPasswordField(String hint) {
    return TextField(
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