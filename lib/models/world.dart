import 'package:realm_writer/helpers/dbhelper.dart';

class World {
  late int id;
  late String worldName;
  late String about;
  late String path;

  World({
    required this.id,
    required this.worldName,
    required this.about,
    required this.path,
  });
  
   World.withoutId({
    this.id = 0,
    required this.worldName,
    required this.about,
    required this.path,
  });
  Map<String, dynamic> toMap() {
    return {
      Dbhelper.worldId: id,
      Dbhelper.worldName: worldName,
      Dbhelper.worldAbout: about,
      Dbhelper.worldPath: path,
    };
  }
  
  Map<String, dynamic> toMapWithoutId() {
    return {
      Dbhelper.worldName: worldName,
      Dbhelper.worldAbout: about,
      Dbhelper.worldPath: path,
    };
  }
}
