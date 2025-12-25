import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:realm_writer/screens/responsive_spacing/responsive_spacing_method.dart';
import 'package:realm_writer/screens/upload_screen/add_photo.dart';

import '../../helpers/dbhelper.dart';
import 'champ_card.dart';
import 'class_types_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchCtr = TextEditingController();
  late Future<List<Map<String, dynamic>>> championsFuture;

  late List<Map<String, dynamic>> allChampions = []; // parang main copy
  late List<Map<String, dynamic>> searchChampions = [];

  @override
  void initState() {
    super.initState();
    loadChampions();
  }

  void loadChampions() async {
    championsFuture = Dbhelper.fetchChampion();
    allChampions = await championsFuture;
    searchChampions = allChampions;
    setState(() {});
  }

  void searchChampion(String searchVal) {
    if (searchVal.trim() == "") {
      searchChampions = allChampions;
    } else {
      searchChampions = allChampions
          .where(
            (champion) => champion[Dbhelper.champName]
                .toString()
                .toLowerCase()
                .contains(searchVal.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  void selectType(String type) {
    if (type == "Tank") {
      searchChampions = allChampions
          .where(
            (champion) =>
                champion[Dbhelper.champType].toString().contains(type),
          )
          .toList();
    } else if (type == "Fighter") {
      searchChampions = allChampions
          .where(
            (champion) =>
                champion[Dbhelper.champType].toString().contains(type),
          )
          .toList();
    } else if (type == "Assassin") {
      searchChampions = allChampions
          .where(
            (champion) =>
                champion[Dbhelper.champType].toString().contains(type),
          )
          .toList();
    } else if (type == "Mage") {
      searchChampions = allChampions
          .where(
            (champion) =>
                champion[Dbhelper.champType].toString().contains(type),
          )
          .toList();
    } else if (type == "Marksman") {
      searchChampions = allChampions
          .where(
            (champion) =>
                champion[Dbhelper.champType].toString().contains(type),
          )
          .toList();
    } else if (type == "Favorite") {
      searchChampions = allChampions
          .where((champion) => champion[Dbhelper.champIsFav] == 1)
          .toList();
    } else {
      searchChampions = allChampions;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111318),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GetDimension.getResponsiveWidth(context, .03),
          vertical: GetDimension.getResponsiveHeight(context, .03),
        ),
        child: SizedBox(
          height: 75,
          width: 75,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const AddPhotoScreen(operation: "add"),
                ),
              );
            },
            backgroundColor: const Color(0xFFC8862C),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(7),
            ),
            child: const Icon(Icons.add, size: 50),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5),
              child: Text(
                "Champions",
                style: TextStyle(color: Color(0xFFC8AA6E), fontSize: 22),
              ),
            ),
            SizedBox(height: GetDimension.getResponsiveHeight(context, .025)),
            //SEARCH TEXTFIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: searchCtr,
                onChanged: searchChampion,
                style: const TextStyle(
                  color: Color(0xFFFBD2AB),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    color: Color(0xFFFBD2AB),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFFBD2AB),
                    size: 24,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF454545),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const Gap(10),
            //CLASSES UNDER SEARCH------------------------
            ClassTypes(selectType: selectType),
            const Gap(10),
            //CHAMPION DATA
            Expanded(
              child: searchChampions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No champions found",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Try a different search term",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: searchChampions.length,
                      itemBuilder: (_, index) {
                        var champion = searchChampions[index];
                        return ChampionCard(
                          champion: champion,
                          onFavToggle: loadChampions,
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
