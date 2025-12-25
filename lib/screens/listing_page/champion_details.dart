
import 'package:flutter/material.dart';
import 'package:realm_writer/helpers/dbhelper.dart';

import 'champion_details_upper.dart';

class ChampionDetails extends StatelessWidget {
  ChampionDetails({super.key, required this.champion});
  final Map<String, dynamic> champion;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF111318),
        body: Column(
          children: [
            // Upper Sec: img, prof, TabBar
            UpperSectionTabs(champion: champion),

            //Lower Section - tabbarView ----------------------------------------------------------------------
            Expanded(
              child: FutureBuilder(
                future: Dbhelper.fetchChampWithWorld(
                  champion[Dbhelper.champId],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data found"));
                  }

                  var details = snapshot.data!.first;
                  String worldAbout = details[Dbhelper.worldAbout]
                      .toString()
                      .replaceAll("{CHAMPION}", details[Dbhelper.champName]);

                  return TabBarView(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          details[Dbhelper.champStory] ?? "No story available",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          worldAbout,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
