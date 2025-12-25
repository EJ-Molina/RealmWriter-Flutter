import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';
import 'package:realm_writer/screens/listing_page/home_screen.dart';
import 'package:realm_writer/screens/responsive_spacing/responsive_spacing_method.dart';
import 'package:realm_writer/screens/upload_screen/add_photo.dart';

import '../../helpers/dbhelper.dart';

class UpperSectionTabs extends StatefulWidget {
  const UpperSectionTabs({super.key, required this.champion});

  final Map<String, dynamic> champion;

  @override
  State<UpperSectionTabs> createState() => _UpperSectionTabsState();
}

class _UpperSectionTabsState extends State<UpperSectionTabs> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Dbhelper.fetchChampWithWorld(widget.champion[Dbhelper.champId]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No champion data found"));
        }

        // for icons
        String getTypeIcon(String type) {
          switch (type.toLowerCase()) {
            case 'assassin':
              return "assets/images/types_images/assassin_icon.webp";
            case 'fighter':
              return "assets/images/types_images/fighter_icon.webp";
            case 'mage':
              return "assets/images/types_images/mage_icon.webp";
            case 'marksman':
              return "assets/images/types_images/marksman_icon.webp";
            case 'support':
              return "assets/images/types_images/support_icon.webp";
            case 'tank':
              return "assets/images/types_images/tank_icon.webp";
            default:
              return "assets/images/types_images/default_icon.png";
          }
        }

        var details =
            snapshot.data!.first; //  kase list parin ang binabalik nito
        String? worldPath = details[Dbhelper.worldPath];
        String? champPath = widget.champion[Dbhelper.champPath];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const  SizedBox(height: 270), //transparent bg
                worldPath != null && worldPath.isNotEmpty
                    ? Image.asset(
                        worldPath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 220,
                      )
                    : Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Text(
                            "No world background",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                // Champion profile picture
                Positioned(
                  bottom: 3,
                  left: 14,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC8AA6E), width: 2),
                    ),
                    child: ClipOval(
                      child: champPath != null && champPath.isNotEmpty
                          ? champPath.startsWith("assets/")
                                ? Image.asset(
                                    champPath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[600],
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    File(champPath),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[600],
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      );
                                    },
                                  )
                          : Container(
                              color: Colors.grey[600],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  left: 5,
                  top: 25,
                  child: Row(
                    mainAxisSize: .max,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Gap(GetDimension.getResponsiveWidth(context, .75)),
                      GestureDetector(
                        onTap: () {
                          deleteAlert(widget.champion[Dbhelper.champId]);
                        },
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details[Dbhelper.champName],
                            style: const TextStyle(
                              color: Color(0xFFC8AA6E),
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                details[Dbhelper.champType],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Gap(8),
                              Image.asset(
                                getTypeIcon(details[Dbhelper.champType]),
                                width: 12,
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddPhotoScreen(
                                    operation: "edit",
                                    editDetails: details,
                                  ),
                                ),
                              );
                              // print(details[Dbhelper.champPath]);
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(60, 25),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              backgroundColor: const Color(0xFFC8862C),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: const Text("Edit", style: TextStyle(fontSize: 11)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(10),
                  Center(
                    child: Text(
                      "\"${details[Dbhelper.champShortBio]}\"",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(5),
                  TabBar(
                    indicatorColor: const Color(0xFFC8AA6E),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    dividerColor: Colors.transparent,
                    labelColor: const Color(0xFFC8AA6E),
                    unselectedLabelColor: const Color(0xFFC8AA6E).withAlpha(180),
                    tabs: const [
                      Tab(text: "Story"),
                      Tab(text: "Origin"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteAlert(int id) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Erase From History",
      text:
          "Once deleted, this champion's legend will be lost to the void forever. Do you dare proceed?",
      backgroundColor: const Color(0xFF111318),
      titleColor: const Color(0xFFC8AA6E),
      textColor: Colors.white,
      confirmBtnColor: const Color(0xFFC8862C),
      confirmBtnText: 'Delete',
      showCancelBtn: true,
      cancelBtnText: "Cancel",
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () {
        Dbhelper.deleteChampion(id);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
    );
  }
}
