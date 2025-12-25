import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:realm_writer/helpers/dbhelper.dart';
import 'package:realm_writer/models/champion.dart';
import 'package:realm_writer/screens/listing_page/home_screen.dart';
import 'package:realm_writer/screens/responsive_spacing/responsive_spacing_method.dart';

class AddStoryScreen extends StatefulWidget {
  AddStoryScreen({
    super.key,
    required this.championName,
    required this.championType,
    required this.championWorld,
    this.shortBio = "",
    this.championImage,
    required this.operation,
    this.editDetails,
  });

  final String operation;
  final Map<String, dynamic>? editDetails;
  final String championName;
  final String championType;
  final String championWorld;
  final String shortBio;
  final File? championImage;

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  var storyCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Prepopulate story text for edit mode
    if (widget.operation == "edit" && widget.editDetails != null) {
      storyCtr.text = widget.editDetails![Dbhelper.champStory] ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111318),
      appBar: AppBar(
        title: Text(
          "${widget.operation == "add" ? "Create" : "Edit"} Story",
          style: const TextStyle(fontSize: 22),
        ),
        foregroundColor: const Color(0xFFC8AA6E),
        backgroundColor: const Color(0xFF111318),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          children: [
            SizedBox(height: GetDimension.getResponsiveHeight(context, 0.04)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC8AA6E),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: storyCtr,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Write your champion's story here...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: GetDimension.getResponsiveHeight(context, 0.03)),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFC8862C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                saveChampion(widget.operation);
              },
              child: const Text(
                "Finish",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: GetDimension.getResponsiveHeight(context, 0.03)),
          ],
        ),
      ),
    );
  }

  void saveChampion(String operation) async {
    if (operation == "add") {
      String? imagePath = widget.championImage?.path;
      int worldId = await Dbhelper.getWorldId(widget.championWorld);
      var champion = Champion.withoutId(
        champName: widget.championName,
        type: widget.championType,
        shortBio: widget.shortBio,
        story: storyCtr.text,
        path: imagePath,
        worldFk: worldId,
      );
      Dbhelper.insertChampion(champion);
    } else {
      String? imagePathEdit = widget.championImage?.path;
      int worldIdEdit = await Dbhelper.getWorldId(widget.championWorld);
      int champEditId = widget.editDetails![Dbhelper.champId];
      var champion = Champion.withoutId(
        champName: widget.championName,
        type: widget.championType,
        shortBio: widget.shortBio,
        story: storyCtr.text,
        path: imagePathEdit,
        worldFk: worldIdEdit,
      );
      Dbhelper.editChampion(champion, champEditId);
    }
    showQuickAlert(widget.operation);
  }

  void showQuickAlert(String operation) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Champion ${operation == "add" ? "Created!" : "Edited!"}",
      text:
          "${widget.championName} has been successfully ${operation == "add" ? "created" : "edited"} and saved to your collection!",
      backgroundColor: const Color(0xFF111318),
      titleColor: const Color(0xFFC8AA6E),
      textColor: Colors.white,
      confirmBtnColor: const Color(0xFFC8862C),
      confirmBtnText: 'OK',
      onConfirmBtnTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
    );
  }
}
