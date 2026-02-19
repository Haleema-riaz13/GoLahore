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
  // State to manage password visibility toggle
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    // --- Translation Logic ---
    // Default English strings
    String title = "LOGIN";
    String subtitle = "on GoLahore";
    String emailHint = "Email or phone";
    String passHint = "Password";
    String googleBtn = "Login with Google";
    String forgotPass = "Forgot password?";
    String noAccount = "Don't have an account? ";
    String signupText = "Sign up";
    String mainBtn = "LOGIN";

    // Urdu translations
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
    }
    // Roman Urdu translations
    else if (widget.language == "Roman Urdu") {
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
      extendBodyBehindAppBar: true,
      // Adjust layout when keyboard appears to prevent overflow
      resizeToAvoidBottomInset: true,
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
          // Background Layer: Themed image
          Positioned.fill(child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover)),
          // Gradient Overlay: Enhances text readability over the background image
          const GradientOverlay(color: Colors.black, opacity: 0.4, endOpacity: 0.85),

          SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ConstrainedBox(
                      // Ensures content spans at least the full screen height
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
                            // Email/Phone input with Glassmorphism effect
                            GlassWrapper(child: _buildTextField(Icons.email_outlined, emailHint)),
                            const SizedBox(height: 20),
                            // Password input with Glassmorphism effect
                            GlassWrapper(child: _buildPasswordField(passHint)),
                            const SizedBox(height: 30),

                            // Social Login Option
                            GestureDetector(
                              onTap: () => print("Google Sign In Clicked"),
                              child: SocialGlassTab(label: googleBtn, icon: Icons.g_mobiledata),
                            ),
                            const SizedBox(height: 25),

                            // Navigation Footer (Forgot Password & Sign Up)
                            _buildFooter(context, forgotPass, noAccount, signupText),

                            const Spacer(),

                            const SizedBox(height: 20),
                            // Main Action: Navigate to Dashboard
                            PrimaryActionButton(
                              label: mainBtn,
                              onTap: () {
                                // Dismiss keyboard before navigation
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
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build the footer navigation links
  Widget _buildFooter(BuildContext context, String forgot, String noAcc, String signup) {
    return Column(
      children: [
        // Navigate to Forgot Password screen
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
            // Navigate to Sign Up screen
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

  /// Helper to build standard text input fields
  Widget _buildTextField(IconData icon, String hint) {
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

  /// Helper to build password input fields with a visibility toggle
  Widget _buildPasswordField(String hint) {
    return TextField(
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