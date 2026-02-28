import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String language;

  const WelcomeScreen({super.key, this.language = "English"});

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
    else if (language == "Roman Urdu") {
      welcomeText = "WELCOME";
      subtitleText = "Smart travel,\nLahore ke liye";
      loginBtn = "LOGIN";
      signupBtn = "Account banayein";
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

          const GradientOverlay(
              color: Colors.black,
              opacity: 0.3,
              endOpacity: 0.8
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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

                        Text(
                          welcomeText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),

                        Text(
                          subtitleText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.2,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        const Spacer(flex: 3),

                        // LOGIN BUTTON with Orange click effect
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                createSmoothRoute(LoginScreen(language: language)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ).copyWith(
                              // UPDATED: Jab click/press karein to Orange ho jaye
                              backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                if (states.contains(WidgetState.pressed)) return Colors.orangeAccent;
                                return null;
                              }),
                            ),
                            child: Text(
                              loginBtn,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // SIGN UP BUTTON with Orange click effect
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                createSmoothRoute(SignUpScreen(language: language)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ).copyWith(
                              // UPDATED: Jab click/press karein to Orange ho jaye
                              backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                if (states.contains(WidgetState.pressed)) return Colors.orangeAccent;
                                return null;
                              }),
                            ),
                            child: Text(
                              signupBtn,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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