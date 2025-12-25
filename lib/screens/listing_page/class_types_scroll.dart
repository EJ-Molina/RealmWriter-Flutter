import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ClassTypes extends StatelessWidget {
  const ClassTypes({super.key, required this.selectType});
  final Function selectType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Gap(20),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("All");
            },
            child: const Text(
              "All",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
           FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Favorite");
            },
            child: const Text(
              "Favorite",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Tank");
            },
            child: const Text(
              "Tank",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Fighter");
            },
            child: const Text(
              "Fighter",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Assassin");
            },
            child: const Text(
              "Assassin",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Mage");
            },
            child: const Text(
              "Mage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC8AA6E),
              maximumSize: const Size(double.infinity, 60),
            ),
            onPressed: () {
              selectType("Marksman");
            },
            child: const Text(
              "Marksman",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
