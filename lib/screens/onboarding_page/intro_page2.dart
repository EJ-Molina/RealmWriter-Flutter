import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/onboard2.png', fit: BoxFit.cover),
              const Text(
                "Create Your Lore",
                style: TextStyle(
                  color: Color(0xFFC8862C),
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(10),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:  Text(
                  "Craft custom champion backstories, rewrite existing ones, or create it in your own imaginations.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
