import 'package:flutter/material.dart';
import 'package:realm_writer/screens/listing_page/home_screen.dart';
import 'package:realm_writer/screens/onboarding_page/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(MyApp(showOnboarding: !onboardingComplete,));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showOnboarding? const OnboardingScreen() : const HomeScreen(),
    );
  }
}
