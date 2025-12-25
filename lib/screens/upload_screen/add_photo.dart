import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:realm_writer/helpers/dbhelper.dart';
import 'package:realm_writer/screens/upload_screen/add_story.dart';
import 'package:realm_writer/screens/upload_screen/photo_box.dart';

import '../responsive_spacing/responsive_spacing_method.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key, required this.operation, this.editDetails});
  final String operation;
  final Map<String, dynamic>? editDetails;
  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final typeList = ["Assassin", "Fighter", "Mage", "Marksman", "Tank"];
  List<String> worldList = [];
  String? image;
  var champNameCtr = TextEditingController();
  var shortBioCtr = TextEditingController();
  String? selectedWorld;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    getWorldNames();

    if (widget.operation == "edit") {
      champNameCtr.text = widget.editDetails![Dbhelper.champName];
      shortBioCtr.text = widget.editDetails![Dbhelper.champShortBio];
      selectedType = widget.editDetails![Dbhelper.champType];
      selectedWorld = widget.editDetails![Dbhelper.worldName];
    }
  }

  void getWorldNames() async {
    var result = await Dbhelper.fetchWorld();
    setState(() {
      worldList = result
          .map((world) => world[Dbhelper.worldName] as String)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111318),
      appBar: AppBar(
        title: Text(
          widget.operation == "add" ? "Create your Champion" : "Edit Champion",
          style: const TextStyle(fontSize: 22),
        ),
        foregroundColor: const Color(0xFFC8AA6E),
        backgroundColor: const Color(0xFF111318),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox( 
                  height: GetDimension.getResponsiveHeight(context, 0.012),
                ), // 1.2% of sc
                widget.operation == "add"
                    ? PhotoBox(
                        image: image,
                        onTap: openGallery,
                        getResponsiveHeight: GetDimension.getResponsiveHeight,
                      )
                    : PhotoBox(
                        image: image ?? widget.editDetails![Dbhelper.champPath],
                        onTap: openGallery,
                        getResponsiveHeight: GetDimension.getResponsiveHeight,
                      ),
                SizedBox(
                  height: GetDimension.getResponsiveHeight(context, 0.05),
                ), //5%
                //ChampName Field
                TextField(
                  controller: champNameCtr,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Champion Name",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC8AA6E),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFFC8AA6E).withValues(alpha: 50),
                        width: 1.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: GetDimension.getResponsiveHeight(context, 0.05),
                ), // 5%
                //DROPDOWN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFC8AA6E)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedType,
                            hint: Text(
                              "Select Type",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: const Color(0xFF454545),
                            items: typeList
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => setState(() {
                              selectedType = value;
                            }),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFC8AA6E)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedWorld,
                            hint: Text(
                              "Select World",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: const Color(0xFF454545),
                            items: worldList
                                .map(
                                  (world) => DropdownMenuItem(
                                    value: world,
                                    child: Text(
                                      world,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => setState(() {
                              selectedWorld = value;
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GetDimension.getResponsiveHeight(context, 0.05),
                ), // 5%
                //SHORT BIO
                TextField(
                  controller: shortBioCtr,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Short Bio",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC8AA6E),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFFC8AA6E).withValues(alpha: 50),
                        width: 1.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: GetDimension.getResponsiveHeight(context, 0.08),
                ), //10%
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFC8862C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    toAddStoryScreen();
                  },
                  child: Text(
                    widget.operation == "add" ? "Next" : "Edit Story",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: GetDimension.getResponsiveHeight(context, 0.03),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toAddStoryScreen() {
    var champName = champNameCtr.text;
    var shortBio = shortBioCtr.text;
    if (champName.trim() == "") {
      quickAlert(
        "Champion Awaits a Name",
        "Every legend needs a name. What shall your champion be called?",
      );
      return;
    }
    if (selectedType == null) {
      quickAlert(
        "Choose Your Path",
        "What role will your champion play? Select their fighting style.",
      );
      return;
    }
    if (selectedWorld == null) {
      quickAlert(
        "Origins Unknown",
        "Every champion hails from a realm. Choose their homeland.",
      );
      return;
    }

    // FOR EDIT OR ADD MODE IMG
    String? finalImagePath;
    if (widget.operation == "add") {
      finalImagePath = image;
    } else {
      // Edit mode: use new select if userselects new,
      finalImagePath = image ?? widget.editDetails![Dbhelper.champPath];
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => AddStoryScreen(
          championName: champName,
          championType: selectedType!,
          championWorld: selectedWorld!,
          shortBio: shortBio,
          championImage: finalImagePath == null ? null : File(finalImagePath),
          operation: widget.operation,
          editDetails: widget.editDetails, // null
        ),
      ),
    );
  }

  void quickAlert(String errorTitle, String errorText) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: errorTitle,
      text: errorText,
      backgroundColor: const Color(0xFF111318),
      titleColor: const Color(0xFFC8AA6E),
      textColor: Colors.white,
      confirmBtnColor: const Color(0xFFC8862C),
      confirmBtnText: 'OK',
    );
  }

  Future openGallery() async {
    final tempImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (tempImage == null) return;

    setState(() {
      image = tempImage.path;
    });
  }
}
