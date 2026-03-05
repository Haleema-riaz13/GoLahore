import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'login_screen_booking.dart';
import 'signup_screen_booking.dart';

class WelcomeScreenBooking extends StatelessWidget {
  final String language;

  const WelcomeScreenBooking({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    String welcomeText = "WELCOME";
    String subtitleText = "Smart travel,\nmade for Lahore";
    String loginBtn = "LOGIN";
    String signupBtn = "Create an account";

    if (language == "Urdu") {
      welcomeText = "خوش آمدید";
      subtitleText = "لاہور کے لیے بہترین\nسمارٹ سفر";
      loginBtn = "لاگ ان";
      signupBtn = "نیا اکاؤنٹ بنائیں";
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/train.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
            ),
          ),
          const GradientOverlay(color: Colors.black, opacity: 0.3, endOpacity: 0.8),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Text(welcomeText, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        Text(subtitleText, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.2, decoration: TextDecoration.underline, fontWeight: FontWeight.w300)),
                        const Spacer(flex: 3),

                        // LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(createSmoothRoute(LoginScreenBooking(language: language)));
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Text(loginBtn, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // SIGN UP BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(createSmoothRoute(SignupScreenBooking(language: language)));
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Text(signupBtn, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}