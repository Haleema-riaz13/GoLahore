import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'private_transport_booking_screen.dart';
import 'signup_screen_booking.dart';
import 'forgot_password_screen.dart';

class LoginScreenBooking extends StatefulWidget {
  final String language;
  const LoginScreenBooking({super.key, required this.language});

  @override
  State<LoginScreenBooking> createState() => _LoginScreenBookingState();
}

class _LoginScreenBookingState extends State<LoginScreenBooking> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isPasswordHidden = true;

  bool get _isFormValid => _emailController.text.isNotEmpty && _passController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
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
    String title = widget.language == "Urdu" ? "لاگ ان" : "LOGIN";
    String subtitle = widget.language == "Urdu" ? "گو لاہور پر" : "on GoLahore";
    String emailHint = widget.language == "Urdu" ? "ای میل یا فون" : "Email or phone";
    String passHint = widget.language == "Urdu" ? "پاس ورڈ" : "Password";
    String googleBtn = widget.language == "Urdu" ? "گوگل کے ساتھ لاگ ان" : "Login with Google";
    String forgotPass = widget.language == "Urdu" ? "پاس ورڈ بھول گئے؟" : "Forgot password?";
    String noAccount = widget.language == "Urdu" ? "اکاؤنٹ نہیں ہے؟ " : "Don't have an account? ";
    String signupText = widget.language == "Urdu" ? "سائن اپ" : "Sign up";
    String mainBtn = widget.language == "Urdu" ? "لاگ ان" : "LOGIN";

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Keyboard ke open hone par UI adjust karne ke liye true rakhein
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
          ),
          const GradientOverlay(color: Colors.black, opacity: 0.5, endOpacity: 0.85),

          SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // Start se alignment
                          children: [
                            const SizedBox(height: 40),
                            Text(title, style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 2)),
                            Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300)),

                            const SizedBox(height: 50),

                            GlassWrapper(
                              child: TextField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
                                  hintText: emailHint,
                                  hintStyle: const TextStyle(color: Colors.white54),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            GlassWrapper(
                              child: TextField(
                                controller: _passController,
                                obscureText: _isPasswordHidden,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white70),
                                    onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                                  ),
                                  hintText: passHint,
                                  hintStyle: const TextStyle(color: Colors.white54),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),
                            SocialGlassTab(label: googleBtn, icon: Icons.g_mobiledata),
                            const SizedBox(height: 30),

                            GestureDetector(
                              onTap: () => Navigator.push(context, createSmoothRoute(ForgotPasswordScreen(language: widget.language))),
                              child: Text(forgotPass, style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(noAccount, style: const TextStyle(color: Colors.white70)),
                                GestureDetector(
                                  onTap: () => Navigator.push(context, createSmoothRoute(SignupScreenBooking(language: widget.language))),
                                  child: Text(signupText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                                ),
                              ],
                            ),

                            // Ye Spacer button ko neeche push karega, lekin LayoutBuilder ki wajah se balance rahega
                            const Spacer(),

                            // Login Button
                            GestureDetector(
                              onTap: _isFormValid ? () {
                                Navigator.pushReplacement(
                                    context,
                                    createSmoothRoute(PrivateTransportBookingScreen(language: widget.language))
                                );
                              } : null,
                              child: Opacity(
                                opacity: _isFormValid ? 1.0 : 0.6,
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF996600),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(mainBtn, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Button ke neeche munasib space
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
}