import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'signup_screen.dart';
import 'search_routes_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final String language;

  const LoginScreen({super.key, this.language = "English"});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- Controllers for managing user input ---
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // --- UI State: Toggle for password visibility ---
  bool _isPasswordHidden = true;

  // --- Logic: Form is valid only if both fields are not empty ---
  bool get _isFormValid => _emailController.text.isNotEmpty && _passController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Add listeners to rebuild the UI and check validation as the user types
    _emailController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Standard practice to dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Translation Mappings ---
    String title = "LOGIN";
    String subtitle = "on GoLahore";
    String emailHint = "Email or phone";
    String passHint = "Password";
    String googleBtn = "Login with Google";
    String forgotPass = "Forgot password?";
    String noAccount = "Don't have an account? ";
    String signupText = "Sign up";
    String mainBtn = "LOGIN";

    if (widget.language == "Urdu") {
      title = "لاگ ان";
      subtitle = "گو لاہور پر";
      emailHint = "ای میل یا فون نمبر";
      passHint = "پاس ورڈ";
      googleBtn = "گوگل کے ساتھ لاگ ان کریں";
      forgotPass = "پاس ورڈ بھول گئے؟";
      noAccount = "اکاؤنٹ نہیں ہے؟ ";
      signupText = "سائن اپ کریں";
      mainBtn = "لاگ ان";
    } else if (widget.language == "Roman Urdu") {
      title = "LOGIN";
      subtitle = "GoLahore par";
      emailHint = "Email ya phone";
      passHint = "Password";
      googleBtn = "Google se login karein";
      forgotPass = "Password bhool gaye?";
      noAccount = "Account nahi hai? ";
      signupText = "Sign up karein";
      mainBtn = "LOGIN";
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows background image to fill the screen
      resizeToAvoidBottomInset: true, // Prevents keyboard from overlapping the UI
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context)
          )
      ),
      body: Stack(
        children: [
          // Visual Branding: Background image with a dark gradient for readability
          Positioned.fill(child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)),
          const GradientOverlay(color: Colors.black, opacity: 0.4, endOpacity: 0.85),

          SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ConstrainedBox(
                      // Ensures the content is at least as tall as the screen
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Text(
                                title,
                                style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: 2)
                            ),
                            Text(
                                subtitle,
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)
                            ),

                            const SizedBox(height: 50),
                            // Input fields wrapped in Glassmorphism effect
                            GlassWrapper(child: _buildTextField(Icons.email_outlined, emailHint, _emailController)),
                            const SizedBox(height: 20),
                            GlassWrapper(child: _buildPasswordField(passHint, _passController)),
                            const SizedBox(height: 30),

                            // Secondary login option: Google OAuth
                            GestureDetector(
                              onTap: () {
                                // Logic for Google Sign In can be added here
                              },
                              child: SocialGlassTab(label: googleBtn, icon: Icons.g_mobiledata),
                            ),
                            const SizedBox(height: 25),

                            // Navigation links: Forgot Password and Sign Up
                            _buildFooter(context, forgotPass, noAccount, signupText),

                            const Spacer(), // Pushes the primary button to the bottom

                            const SizedBox(height: 20),

                            // MAIN LOGIN BUTTON: Enabled only when form is valid
                            GestureDetector(
                              onTap: _isFormValid ? () {
                                FocusScope.of(context).unfocus(); // Close keyboard before navigating
                                Navigator.of(context).pushReplacement(
                                  createSmoothRoute(SearchRoutesScreen(language: widget.language)),
                                );
                              } : null,
                              child: Opacity(
                                opacity: _isFormValid ? 1.0 : 0.5,
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.orange, // Solid Orange theme color
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    mainBtn,
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
                            const SizedBox(height: 40),
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

  /// Helper widget for the bottom navigation links (Forgot Password & Signup)
  Widget _buildFooter(BuildContext context, String forgot, String noAcc, String signup) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).push(
                createSmoothRoute(ForgotPasswordScreen(language: widget.language))
            );
          },
          child: Text(
              forgot,
              style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline)
          ),
        ),

        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(noAcc, style: const TextStyle(color: Colors.white70)),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).push(createSmoothRoute(SignUpScreen(language: widget.language)));
              },
              child: Text(
                  signup,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper for building the generic email/phone input field
  Widget _buildTextField(IconData icon, String hint, TextEditingController controller) {
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

  /// Helper for building the password field with a visibility toggle
  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return TextField(
        controller: controller,
        obscureText: _isPasswordHidden,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
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