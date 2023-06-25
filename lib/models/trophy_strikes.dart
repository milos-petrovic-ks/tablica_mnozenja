import 'package:flutter/material.dart';
import '../utils/globals.dart';
import '../widgets/trophy_tile_widgets.dart';
import 'person.dart';
import 'trophy.dart';

class TrophyStrikes extends Trophy {
  // GREY, BRONZE, SILVER, ZLATO
  final List<String> levelsNames = ["NONE", "BRON", "SILV", "GOLD"];
  final List<int> badgeBounds = Globals.strikestBadgeBounds;
  int targetNumber;
  TrophyStrikes({
    required this.targetNumber,
    required String title,
    String? explanation,
  }) : super(
          imageTemplate: "assets/trophies/V2-MED.png",
          title: title,
          explanation: explanation,
        );

  @override
  Widget display(double pageWidth) {
    int strikes = Globals.loggedPerson.strikes[targetNumber - 1];
    int maxNumStrikes = Globals.loggedPerson.maxStrikes[targetNumber - 1];
    int level = _level();

    int? nextBound = level == 3 ? null : badgeBounds[level];
    String textInBar = "MAX COMBO = $maxNumStrikes";
    double percentageDone = nextBound == null ? 1 : maxNumStrikes / nextBound;
    String titleTop = "$title: COMBO = $strikes";
    return TrophyTile.trophieTile(
      pageWidth,
      levelsNames,
      level,
      _imgSource(),
      titleTop,
      percentageDone,
      textInBar,
    );
  }

  @override
  int starsCount() {
    return _level();
  }

  @override
  int maxStars() {
    return 3;
  }

  int _level() {
    Person p = Globals.loggedPerson;
    int strikes = p.maxStrikes[targetNumber - 1];
    int level = 0;
    for (int levelBound in badgeBounds) {
      if (strikes >= levelBound) {
        level = level + 1;
      }
    }
    return level;
  }

  String _imgSource() {
    return imageTemplate.replaceAll("MED", levelsNames[_level()]);
  }
}
