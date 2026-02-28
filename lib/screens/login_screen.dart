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
      extendBodyBehindAppBar: true,
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
                            GlassWrapper(child: _buildTextField(Icons.email_outlined, emailHint, _emailController)),
                            const SizedBox(height: 20),
                            GlassWrapper(child: _buildPasswordField(passHint, _passController)),
                            const SizedBox(height: 30),

                            GestureDetector(
                              onTap: () => print("Google Sign In Clicked"),
                              child: SocialGlassTab(label: googleBtn, icon: Icons.g_mobiledata),
                            ),
                            const SizedBox(height: 25),

                            _buildFooter(context, forgotPass, noAccount, signupText),

                            const Spacer(),

                            const SizedBox(height: 20),

                            // UPDATED: LOGIN Button with PLAIN ORANGE color
                            GestureDetector(
                              onTap: _isFormValid ? () {
                                FocusScope.of(context).unfocus();
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
                                    color: Colors.orange, // Plain Orange
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