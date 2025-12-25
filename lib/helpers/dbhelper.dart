import 'package:path/path.dart';
import 'package:realm_writer/models/champion.dart';
import 'package:realm_writer/models/world.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  static const String dbName = "realm.db";
  static const dbVersion = 5;

  //CHAMPION TABLE
  static const String championTb = "champion";
  static const String champId = "champId";
  static const String champName = "champName";
  static const String champType = "type";
  static const String champShortBio = "shortBio";
  static const String champStory = "story";
  static const String champPath = "champPath";
  static const String champWorldFk = "worldFk";
  static const String champIsFav = "isFav";

  //WORLD TABLE
  static const String worldTb = "world";
  static const String worldId = "worldId";
  static const String worldName = "worldName";
  static const String worldAbout = "about";
  static const String worldPath = "worldPath";

  static Future<Database> openDb() async {
    var path = join(await getDatabasesPath(), dbName);

    var createChampionTable =
        '''
    CREATE TABLE IF NOT EXISTS $championTb(
      $champId INTEGER PRIMARY KEY AUTOINCREMENT,
      $champName VARCHAR(150) NOT NULL,
      $champType VARCHAR(50) NOT NULL,
      $champShortBio VARCHAR(200),
      $champStory TEXT,
      $champPath TEXT,
      $champWorldFk INTEGER,
      $champIsFav INTEGER DEFAULT 0,
      FOREIGN KEY($champWorldFk) REFERENCES $worldTb($worldId) ON DELETE CASCADE ON UPDATE CASCADE
    )''';

    var createWorldTable =
        '''
    CREATE TABLE IF NOT EXISTS $worldTb(
      $worldId INTEGER PRIMARY KEY AUTOINCREMENT,
      $worldName VARCHAR(150),
      $worldAbout TEXT,
      $worldPath TEXT
    )
    ''';

    var db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await db.execute(createChampionTable);
        await db.execute(createWorldTable);
        print("Created both tables.");

        await _defineWorlds(db);
        await _defineChampions(db);
        print("Created predefined worlds.");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion <= oldVersion) return;
        await db.execute('DROP TABLE IF EXISTS $championTb');
        await db.execute('DROP TABLE IF EXISTS $worldTb');
        await db.execute(createChampionTable);
        await db.execute(createWorldTable);
        await _defineWorlds(db);
        print("UPGRADE SUCCESS");
      },
    );

    return db;
  }

  // ALL ABOUT WORLD-----------------------------------
  static void createWorld(World w) async {
    var db = await openDb();
    await db.insert(worldTb, w.toMapWithoutId());
  }

  static Future<List<Map<String, dynamic>>> fetchWorld() async {
    var db = await openDb();
    return await db.query(worldTb);
  }

  // Get world ID by world name
  static Future<int> getWorldId(String worldChose) async {
    var db = await openDb();
    var result = await db.query(
      worldTb,
      where: "${Dbhelper.worldName} = ?",
      whereArgs: [worldChose],
    );

    return result.first[worldId]! as int;
  }

  // ALL ABOUT CHAMPIONS-----------------------------------
  static void insertChampion(Champion c) async {
    var db = await openDb();
    await db.insert(championTb, c.toMapWithoutId());
  }

  static Future<List<Map<String, dynamic>>> fetchChampion() async {
    var db = await openDb();
    return await db.query(championTb);
  }

  static Future<void> toggleFav(int id, int currentIsFav) async {
    var db = await openDb();
    await db.update(
      championTb,
      {champIsFav: currentIsFav == 0 ? 1 : 0},
      where: "$champId = ?",
      whereArgs: [id],
    );
  }

  static Future<void> editChampion(Champion c, int champEditId) async {
    var db = await openDb();
    int count = await db.update(
      championTb,
      c.toMapWithoutId(),
      where: "$champId = ?",
      whereArgs: [champEditId],
    );
    print('Rows updated: $count');
  }

  static Future<void> deleteChampion(int id) async {
    var db = await openDb();
    await db.delete(championTb, where: "$champId = ?", whereArgs: [id]);
  }

  //method to get world and champ using join
  static Future<List<Map<String, dynamic>>> fetchChampWithWorld(int id) async {
    var db = await openDb();
    var result = await db.rawQuery(
      "SELECT * FROM $championTb JOIN $worldTb ON $championTb.$champWorldFk = $worldTb.$worldId WHERE $championTb.$champId = ?",
      [id],
    );

    return result;
  }

  // method to pre populate the worldTB on new run/install
  static Future<void> _defineWorlds(Database db) async {
    List<World> worlds = [
      World.withoutId(
        worldName: "Noxus",
        about:
            "Forged in ambition and strength, Noxus is a nation where only the powerful rise. From this relentless empire comes {CHAMPION}, shaped by a culture that values might, strategy, and the will to conquer.",
        path: "assets/images/map_images/noxus_map.jpg",
      ),
      World.withoutId(
        worldName: "Piltover & Zaun",
        about:
            "Born from a land of invention and chaos, Piltover and Zaun stand as twin cities of progress and survival. In this world of brilliance and danger, {CHAMPION} emerges, influenced by innovation above and struggle below.",
        path: "assets/images/map_images/piltover_map.jpg",
      ),
      World.withoutId(
        worldName: "Demacia",
        about:
            "Built on honor, discipline, and unwavering tradition, Demacia stands as a bastion of order. From this proud kingdom comes {CHAMPION}, carrying the ideals of duty, justice, and unbreakable resolve.",
        path: "assets/images/map_images/demacia_map.jpg",
      ),
      World.withoutId(
        worldName: "Shurima",
        about:
            "Once a glorious empire lost to the sands, Shurima rises again through ancient power and forgotten legends. From this sun-scorched land, {CHAMPION} walks a path shaped by legacy, survival, and destiny.",
        path: "assets/images/map_images/shurima_map.jpg",
      ),
      World.withoutId(
        worldName: "Ionia",
        about:
            "Guided by balance, spirit, and ancient magic, Ionia is a land where nature and tradition intertwine. From this harmonious realm comes {CHAMPION}, bound to the flow of energy, discipline, and inner strength.",
        path: "assets/images/map_images/ionia_map.jpg",
      ),
    ];

    for (World world in worlds) {
      await db.insert(worldTb, world.toMapWithoutId());
    }
  }

  //initial champ on install
  static Future<void> _defineChampions(Database db) async {
    List<Champion> champions = [
      Champion.withoutId(
        champName: "Talon",
        type: "Assassin",
        shortBio: "Only fools pledge life to honor.",
        story:
            '''Talon was shaped by the shadows of Noxus, where survival mattered more than mercy. As a child, he learned quickly that weakness invited death. The streets taught him how to steal, how to hide, and how to strike first. Every scar he carried was a lesson paid for in blood.

His talent for killing did not go unnoticed. Talon was taken in by General Du Couteau, not out of kindness, but recognition. Under his command, Talon became a living blade, trained to eliminate threats before they could be named. Loyalty was expected, questions were not. He carried out orders with precision, believing purpose was found only in obedience.

When General Du Couteau vanished, Talon was left without direction. Noxus praised strength, yet offered no answers. He began hunting those who claimed power without earning it, judging them by his own ruthless standards. Each assassination was not just an act of duty, but a test of worth.

Now Talon walks alone through Noxus, unseen and unforgiving. He is not a hero, nor does he seek redemption. He is the silence before death, a reminder that in Noxus, power is taken, not given, and only the sharpest blade survives.''',
        worldFk: 1,
        path: "assets/images/champ_images/talon.jpg",
      ),

      Champion.withoutId(
        champName: "Azir",
        type: "Mage",
        shortBio: "What is the desert, but the ashes of my enemies?",
        story:
            '''Azir was born to rule Shurima, yet spent much of his early life as a slave within his own empire. Stripped of power and freedom, he learned patience instead of pride, dreaming of a future where Shurima would rise through unity rather than chains. When fate finally placed the crown upon his head, Azir vowed to end the cruelty that defined his empire.

His vision came too late. Betrayed by those closest to him, Azir was struck down at the moment he sought to free his people. Shurima fell with him, buried beneath sand and forgotten by the world. In death, his dream seemed destined to fade into myth.

Centuries later, Azir was reborn through ancient Ascension, awakened as an emperor of living sand. He rose to find his empire in ruins, his name reduced to legend. Yet his resolve remained unbroken. He did not return for vengeance alone, but to rebuild what was lost.

Now Azir commands the desert itself, shaping soldiers from sand and memory. He stands as both ruler and servant of Shurima, driven by a single purpose. To restore an empire not through fear, but through the promise of a future worthy of its past.''',
        worldFk: 4,
        path: "assets/images/champ_images/azir.jpg",
      ),

      Champion.withoutId(
        champName: "Ezreal",
        type: "Marksman",
        shortBio: "A beaten path is a boring path.",
        story:
            '''Ezreal grew up in Piltover surrounded by maps, journals, and unanswered questions. His parents were famed explorers who chased ancient secrets across Runeterra, leaving him behind with promises they never kept. When they vanished on an expedition, Ezreal was left with their absence and a need to prove that he was more than the boy they abandoned.

Brilliant and reckless, he turned to archaeology not out of respect for history, but to chase the echoes of his parents' footsteps. Ruins became his classrooms, danger his teacher. In a forgotten tomb, he uncovered a mysterious gauntlet that answered his touch with raw arcane power. It should have terrified him. Instead, it made him feel chosen, like the world was finally paying attention.

Ezreal masks his loneliness with confidence and humor, but every adventure is driven by the same question. Were his parents searching for glory, or were they searching for something they could never return from? Each artifact he uncovers feels like it might be the clue that brings him closer to the truth.

Now known as the Prodigal Explorer, Ezreal dives headfirst into danger with a grin and a spell at his fingertips. Beneath the bravado is a young man still chasing answers across ancient stone and forgotten magic, hoping that somewhere in the ruins of the past, he will finally find where he belongs.
''',
        worldFk: 4,
        path: "assets/images/champ_images/ezreal.jpg",
      ),

      Champion.withoutId(
        champName: "Garen",
        type: "Fighter",
        shortBio: "Demaciaaaaaaaaa",
        story:
            '''Garen of Demacia was raised beneath banners of stone and steel, in a kingdom where honor was not a choice but a duty. From a young age, he was taught that Demacia stood because its people never wavered, and neither should he. While others dreamed of glory, Garen learned discipline, training until his hands bled and his voice cracked from shouting oaths he meant to keep.

As he rose through the ranks of the Dauntless Vanguard, his strength became unquestioned, but his resolve was tested in quieter ways. Demacia’s hatred of magic forced Garen into silence about his deepest conflict. His own sister, Lux, carried a power the kingdom feared. Loving her meant carrying a secret that could shatter everything he stood for. Each battle he fought for Demacia felt heavier, knowing the laws he defended could one day condemn his blood.

War hardened him, but doubt followed. On the battlefield, Garen never faltered, spinning through enemy lines like a living standard of Demacian might. Away from it, he questioned what true justice meant when mercy had no place in the law. He began to understand that strength was not only found in the sword, but in the courage to protect what others would destroy.

Garen remains Demacia’s shield, unwavering in battle, yet changed within. He fights not just for crown and country, but for a future where loyalty does not demand the sacrifice of family. In a land built on rigid ideals, Garen stands as proof that even the strongest stone can learn to bend without breaking.
''',
        worldFk: 3,
        path: "assets/images/champ_images/garen.jpg",
      ),

      Champion.withoutId(
        champName: "Irelia",
        type: "Fighter",
        shortBio:
            "We will live on... either in victory, or in the scars we leave on them!",
        story:
            '''Irelia of Ionia was once just a dancer, her life shaped by rhythm, tradition, and the quiet beauty of her homeland. She learned the sacred movements not for war, but to honor history, each step a story passed down through generations. When the Noxian invasion shattered Ionia's peace, that art was torn from its purpose and twisted into something far more dangerous.

Her family paid the price of resistance. One by one, they fell, leaving Irelia alone with grief and anger she did not know how to carry. In the ruins of her home, the very blades meant to decorate her dance answered her pain. They rose and moved as if guided by Ionia itself, transforming her sorrow into a weapon. In that moment, Irelia stopped being a child of tradition and became a symbol of defiance.

Thrown into leadership far too young, she fought battles she never asked for. Every victory against Noxus deepened her legend, yet each one cost her another piece of the life she had lost. Irelia struggled with the weight of command, haunted by the thought that survival demanded endless bloodshed. She wanted peace, but war kept choosing her.

Still, she fights on, not out of hatred, but out of love for what remains. Irelia moves across the battlefield like a living memory of Ionia, graceful and unyielding. Through every clash of steel, she carries the hope that one day, her blades will no longer need to dance for war, but for the homeland she refuses to let die.
''',
        worldFk: 5,
        path: "assets/images/champ_images/irelia.jpg",
      ),

      Champion.withoutId(
        champName: "Leblanc",
        type: "Mage",
        shortBio: "I let them see only what I want them to see",
        story:
            '''LeBlanc has worn many faces, but none of them are her true one. In Noxus, she moves through courts and battlefields alike as a whisper, shaping events without ever standing in the light. Long before empires rose and fell, she learned that knowledge and deception were the sharpest weapons of all.

As the architect behind the Black Rose, LeBlanc has guided Noxus from the shadows, manipulating rulers and rewriting history when it suited her designs. She does not rule through crowns or armies, but through secrets, illusions, and carefully placed lies. Those who believe they understand her are already lost.

Her greatest fear is not death, but chaos beyond control. Ancient powers stir beneath the world, and LeBlanc sees herself as the only one cunning enough to hold them at bay. Every scheme she weaves serves a purpose known only to her, even if it means sacrificing nations as pawns.

To Noxus, LeBlanc is a myth, a traitor, or a savior depending on who tells the story. In truth, she is all of them. While others fight for glory or domination, LeBlanc fights for influence, ensuring that no matter who sits on the throne, the shadows will always answer to her.
''',
        worldFk: 1,
        path: "assets/images/champ_images/leblanc.jpg",
      ),
    ];

    for (var champ in champions) {
      await db.insert(championTb, champ.toMapWithoutId());
    }
  }
}
