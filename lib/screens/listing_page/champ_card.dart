import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realm_writer/screens/listing_page/champion_details.dart';

import '../../helpers/dbhelper.dart';

class ChampionCard extends StatefulWidget {
  const ChampionCard({
    super.key,
    required this.champion,
    required this.onFavToggle,
  });

  final VoidCallback onFavToggle;
  final Map<String, dynamic> champion;

  @override
  State<ChampionCard> createState() => _ChampionCardState();
}

class _ChampionCardState extends State<ChampionCard> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => ChampionDetails(champion: widget.champion),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF454545), Color(0xFF232323)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.brown.withValues(alpha: .35),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(color: const Color(0xFFC8862C), width: 1.2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 13.0,
                right: 13,
                top: 12,
                bottom: 2,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: widget.champion[Dbhelper.champPath] != null
                      ? widget.champion[Dbhelper.champPath]
                                .toString()
                                .startsWith("assets/")
                            ? Image.asset(
                                widget.champion[Dbhelper.champPath],
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
                                File(widget.champion[Dbhelper.champPath]),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[600],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey[400],
                                      size: 40,
                                    ),
                                  );
                                },
                              )
                      : Container(
                          color: Colors.grey[600],
                          child: Icon(
                            Icons.person,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
              dense: true,
              title: Text(
                widget.champion[Dbhelper.champName] ?? "Unknown",
                style: const TextStyle(color: Color(0xFFFBD2AB), fontSize: 14),
              ),
              subtitle: Text(
                widget.champion[Dbhelper.champType] ?? "Unknown",
                style: TextStyle(color: Colors.grey[300], fontSize: 11),
              ),
              trailing: GestureDetector(
                onTap: () async {
                  await Dbhelper.toggleFav(
                    widget.champion[Dbhelper.champId],
                    widget.champion[Dbhelper.champIsFav] ?? 0,
                  );
                  widget.onFavToggle();
                },
                child: Icon(
                  (widget.champion[Dbhelper.champIsFav] ?? 0) == 1
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: const Color(0xFFC8862C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
