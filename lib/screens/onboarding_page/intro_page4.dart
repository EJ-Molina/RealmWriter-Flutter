import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/images/onboard4.png'),
            const Text(
              "Everything Stays With You",
              style: TextStyle(
                color: Color(0xFFC8862C),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "All stories and memories are stored on your device. No accounts, no online setup, just pure creativity.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}