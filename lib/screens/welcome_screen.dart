import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String language;

  // Constructor receiving the selected language (Defaults to English)
  const WelcomeScreen({super.key, this.language = "English"});

  @override
  Widget build(BuildContext context) {
    // Default text values for English
    String welcomeText = "WELCOME";
    String subtitleText = "Smart travel,\nmade for Lahore";
    String loginBtn = "LOGIN";
    String signupBtn = "Create an account";

    // Logic to switch text based on the passed language string
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
          // Background image layer (The train visual)
          Positioned.fill(
            child: Image.asset(
              'assets/train.jpg',
              fit: BoxFit.cover,
              // Fallback color if the image asset is missing
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
            ),
          ),

          // Custom gradient overlay to ensure text is readable over the image
          const GradientOverlay(
              color: Colors.black,
              opacity: 0.3,
              endOpacity: 0.8
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Navigation: Back button
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

                        // Main Welcome Heading
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

                        // Subtitle with specific spacing and underline decoration
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

                        // LOGIN BUTTON: Outlined style with dynamic press feedback
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
                              // Logic: Change background to OrangeAccent when the user touches the button
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

                        // SIGN UP BUTTON: Similar style to Login with orange feedback
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
                              // Logic: Flash Orange when pressed for visual confirmation
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