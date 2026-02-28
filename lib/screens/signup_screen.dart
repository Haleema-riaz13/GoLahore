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
  // Controllers to track input changes
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  // State variables to manage password visibility toggles
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  // Validation Logic: Checks if all fields are filled
  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _confirmPassController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    // Listeners to rebuild UI when user types
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
    _confirmPassController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Translation Logic ---
    String title = "Sign Up";
    String subtitle = "on GoLahore";
    String nameHint = "Name";
    String emailHint = "Email";
    String phoneHint = "+92 Phone";
    String passInstruction = " Use 8+ characters, include a number or symbol";
    String createPassHint = "Create Password";
    String confirmPassHint = "Confirm Password";
    String mainBtn = "SIGN UP";

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
    } else if (widget.language == "Roman Urdu") {
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
          const GradientOverlay(color: Colors.black, opacity: 0.5, endOpacity: 0.8),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        Text(title, style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold)),
                        Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300)),

                        const SizedBox(height: 30),
                        GlassWrapper(child: _buildField(Icons.person_outline, nameHint, _nameController)),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildField(Icons.email_outlined, emailHint, _emailController)),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildField(Icons.phone_outlined, phoneHint, _phoneController)),
                        const SizedBox(height: 25),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(passInstruction, style: const TextStyle(color: Colors.white60, fontSize: 12))
                        ),
                        const SizedBox(height: 5),
                        GlassWrapper(child: _buildPasswordField(createPassHint, _isPasswordHidden, _passController, (val) => setState(() => _isPasswordHidden = val))),
                        const SizedBox(height: 12),
                        GlassWrapper(child: _buildPasswordField(confirmPassHint, _isConfirmPasswordHidden, _confirmPassController, (val) => setState(() => _isConfirmPasswordHidden = val))),

                        const Spacer(),

                        const SizedBox(height: 20),

                        // UPDATED: SIGN UP Button with PLAIN ORANGE color and Validation
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
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildPasswordField(String hint, bool isHidden, TextEditingController controller, Function(bool) onToggle) {
    return TextField(
        controller: controller,
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