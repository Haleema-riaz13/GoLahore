import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'private_transport_booking_screen.dart';

class SignupScreenBooking extends StatefulWidget {
  final String language;
  const SignupScreenBooking({super.key, required this.language});

  @override
  State<SignupScreenBooking> createState() => _SignupScreenBookingState();
}

class _SignupScreenBookingState extends State<SignupScreenBooking> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _passController.text.isNotEmpty &&
          _confirmPassController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
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
    String title = widget.language == "Urdu" ? "سائن اپ" : "Sign Up";
    String subtitle = widget.language == "Urdu" ? "گو لاہور پر" : "on GoLahore";
    String nameHint = widget.language == "Urdu" ? "نام" : "Name";
    String emailHint = widget.language == "Urdu" ? "ای میل" : "Email";
    String phoneHint = widget.language == "Urdu" ? "فون نمبر" : "+92 Phone";
    String passInstruction = widget.language == "Urdu"
        ? "8 یا زیادہ حروف، نمبر یا علامت شامل کریں"
        : "Use 8+ characters, include a number or symbol";
    String createPassHint = widget.language == "Urdu" ? "پاس ورڈ بنائیں" : "Create Password";
    String confirmPassHint = widget.language == "Urdu" ? "پاس ورڈ کی تصدیق کریں" : "Confirm Password";
    String mainBtn = widget.language == "Urdu" ? "سائن اپ" : "SIGN UP";

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true, // Keyboard ke liye space banayega
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
                          children: [
                            const SizedBox(height: 10),
                            Text(title, style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold)),
                            Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w300)),

                            const SizedBox(height: 30),

                            GlassWrapper(child: _buildField(Icons.person_outline, nameHint, _nameController)),
                            const SizedBox(height: 12),
                            GlassWrapper(child: _buildField(Icons.email_outlined, emailHint, _emailController)),
                            const SizedBox(height: 12),
                            GlassWrapper(child: _buildField(Icons.phone_outlined, phoneHint, _phoneController)),

                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(passInstruction, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                            ),
                            const SizedBox(height: 10),

                            GlassWrapper(
                              child: _buildPasswordField(createPassHint, _isPasswordHidden, _passController, (val) => setState(() => _isPasswordHidden = val)),
                            ),
                            const SizedBox(height: 12),
                            GlassWrapper(
                              child: _buildPasswordField(confirmPassHint, _isConfirmPasswordHidden, _confirmPassController, (val) => setState(() => _isConfirmPasswordHidden = val)),
                            ),

                            // Ye Spacer saari faltu space cover kar lega aur button ko neeche push karega
                            const Spacer(),

                            const SizedBox(height: 20),

                            GestureDetector(
                              onTap: _isFormValid ? () {
                                FocusScope.of(context).unfocus();
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
                                  child: Text(
                                    mainBtn,
                                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                  ),
                                ),
                              ),
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

  Widget _buildField(IconData icon, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
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
          onPressed: () => onToggle(!isHidden),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}