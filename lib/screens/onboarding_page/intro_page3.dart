import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/images/onboard3.png', fit: BoxFit.cover,),
            const Text(
              "Keep Your Moments Alive",
              style: TextStyle(
                color: Color(0xFFC8862C),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Save personal highlights and experiences with your champions, from big victories to small moments you want to remember.",
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