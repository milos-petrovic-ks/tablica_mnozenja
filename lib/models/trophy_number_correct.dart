import 'package:flutter/material.dart';
import '../widgets/trophy_tile_widgets.dart';
import 'person.dart';
import 'trophy.dart';
import '../utils/globals.dart';

class TrophyNumberCorrect extends Trophy {
  static List<String> levelsNames = ["NONE", "BRON", "SILV", "GOLD"];
  static List<int> badgeBounds = Globals.numberCorrectBadgeBounds;

  int targetNumber;
  TrophyNumberCorrect({
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
    int numCorrect = Globals.loggedPerson.correctAnswersPerNumber(targetNumber);
    int level = _level();
    int? nextBound = level == 3 ? null : badgeBounds[level];
    String textInBar = nextBound == null
        ? numCorrect.toString()
        : "${numCorrect.toString()} / ${nextBound.toString()}";
    double percentageDone = nextBound == null ? 1 : numCorrect / nextBound;

    return TrophyTile.trophieTile(
      pageWidth,
      levelsNames,
      level,
      _imgSource(),
      title,
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
    int numCorrect = p.correctAnswersPerNumber(targetNumber);
    int level = 0;
    for (int levelBound in badgeBounds) {
      if (numCorrect >= levelBound) {
        level = level + 1;
      }
    }
    return level;
  }

  String _imgSource() {
    return imageTemplate.replaceAll("MED", levelsNames[_level()]);
  }
}
