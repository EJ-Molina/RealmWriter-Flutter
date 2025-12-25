import 'package:realm_writer/helpers/dbhelper.dart';

class Champion {
  late int id;
  late String champName;
  late String type;
  late String shortBio;
  late String story;
  late String? path;
  late bool isFav;
  late int worldFk;

  Champion({
    required this.id,
    required this.champName,
    required this.type,
    required this.shortBio,
    required this.story,
    this.path,
    this.isFav = false,
    required this.worldFk,
  });

  Champion.withoutId({
    this.id = 0,
    required this.champName,
    required this.type,
    required this.shortBio,
    required this.story,
    this.path,
    this.isFav = false,
    required this.worldFk,
  });
  Map<String, dynamic> toMap() {
    return {
      Dbhelper.champId: id,
      Dbhelper.champName: champName,
      Dbhelper.champType: type,
      Dbhelper.champShortBio: shortBio,
      Dbhelper.champStory: story,
      Dbhelper.champPath: path,
      Dbhelper.champWorldFk: worldFk,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      Dbhelper.champName: champName,
      Dbhelper.champType: type,
      Dbhelper.champShortBio: shortBio,
      Dbhelper.champStory: story,
      Dbhelper.champPath: path,
      Dbhelper.champWorldFk: worldFk,
    };
  }
}
