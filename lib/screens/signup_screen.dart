import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'search_routes_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String language;

  const SignUpScreen({super.key, this.language = "English"});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // State variables to manage password visibility toggles
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    // --- Translation Logic ---
    // Default English strings
    String title = "Sign Up";
    String subtitle = "on GoLahore";
    String nameHint = "Name";
    String emailHint = "Email";
    String phoneHint = "+92 Phone";
    String passInstruction = " Use 8+ characters, include a number or symbol";
    String createPassHint = "Create Password";
    String confirmPassHint = "Confirm Password";
    String mainBtn = "SIGN UP";

    // Urdu translations
    if (widget.language == "Urdu") {
      title = "سائن اپ";
      subtitle = "گو لاہور پر";
      nameHint = "نام";
      emailHint = "ای میل";
      phoneHint = "فون نمبر";
      passInstruction = " 8 یا زیادہ حروف، نمبر یا علامت شامل کریں";
      createPassHint = "پاس ورڈ بنائیں";
      confirmPassHint = "پاس ورڈ کی تصدیق کریں";
      mainBtn = "سائن اپ";
    }
    // Roman Urdu translations
    else if (widget.language == "Roman Urdu") {
      title = "Sign Up";
      subtitle = "GoLahore par";
      nameHint = "Naam";
      emailHint = "Email";
      phoneHint = "Phone number";
      passInstruction = " 8+ characters, number ya symbol use karein";
      createPassHint = "Password banayein";
      confirmPassHint = "Confirm Password";
      mainBtn = "SIGN UP";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Ensures the layout adjusts correctly when the keyboard appears
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context) // Go back to the previous screen
          )
      ),
      body: Stack(
        children: [
          // Background Layer: Themed image
          Positioned.fill(child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)),
          // Gradient Overlay: Ensures text is readable over the background
          const GradientOverlay(color: Colors.black, opacity: 0.5, endOpacity: 0.8),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                // Physics enabled to ensure smooth scrolling during keyboard interaction
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  // Forces the scrollable area to take at least the full screen height
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        Text(
                            title,
                            style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold)
                        ),
                        Text(
                            subtitle,
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300)
                        ),

                        const SizedBox(height: 30),
                        // Input fields wrapped in Glassmorphism style
                        GlassWrapper(child: _buildField(Icons.person_outline, nameHint)),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildField(Icons.email_outlined, emailHint)),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildField(Icons.phone_outlined, phoneHint)),
                        const SizedBox(height: 25),

                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(passInstruction, style: const TextStyle(color: Colors.white60, fontSize: 12))
                        ),
                        const SizedBox(height: 5),

                        // Password fields with visibility toggles
                        GlassWrapper(child: _buildPasswordField(createPassHint, _isPasswordHidden, (val) => setState(() => _isPasswordHidden = val))),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildPasswordField(confirmPassHint, _isConfirmPasswordHidden, (val) => setState(() => _isConfirmPasswordHidden = val))),

                        // Spacer pushes the button to the bottom while allowing scroll space
                        const Spacer(),

                        const SizedBox(height: 20),
                        // Main Action: Dismisses keyboard and navigates to the Dashboard
                        PrimaryActionButton(
                          label: mainBtn,
                          onTap: () {
                            // Dismiss the keyboard automatically
                            FocusScope.of(context).unfocus();

                            Navigator.of(context).pushReplacement(
                              createSmoothRoute(SearchRoutesScreen(language: widget.language)),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build standard text input fields
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

  /// Helper widget to build password input fields with toggleable visibility
  Widget _buildPasswordField(String hint, bool isHidden, Function(bool) onToggle) {
    return TextField(
        obscureText: isHidden,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
            suffixIcon: IconButton(
                icon: Icon(isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white70),
                onPressed: () => onToggle(!isHidden)
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15)
        )
    );
  }
}