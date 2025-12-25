import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/onboard1.png', fit: BoxFit.cover,),
              const Text(
                "Welcome to RealmWriter",
                style: TextStyle(
                  color: Color(0xFFC8862C),
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(10),
              const Text(
                "A space where you can create, rewrite, and remember champion stories in your own way.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
