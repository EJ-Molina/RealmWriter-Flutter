import 'package:flutter/material.dart';
import 'package:realm_writer/screens/listing_page/home_screen.dart';
import 'package:realm_writer/screens/onboarding_page/intro_page1.dart';
import 'package:realm_writer/screens/onboarding_page/intro_page3.dart';
import 'package:realm_writer/screens/onboarding_page/intro_page4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_page2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageCtrl = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                isLast = index == 3;
                setState(() {});
              },
              controller: pageCtrl,
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
                IntroPage4(),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.90),
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  //SKIP
                  GestureDetector(
                    onTap: () {
                      pageCtrl.jumpToPage(3);
                    },
                    child: const Text("Skip"),
                  ),
                  SmoothPageIndicator(controller: pageCtrl, count: 4),
                  //NEXT
                  GestureDetector(
                    onTap: () async {
                      if (isLast) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('onboardingComplete', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                        return;
                      }
                      pageCtrl.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(isLast ? "Done" : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
