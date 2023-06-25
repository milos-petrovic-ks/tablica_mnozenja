import 'trophy.dart';
import 'trophy_number_correct.dart';
import '../models/trophy_strikes.dart';

class TrophiesCollections {
  static List<TrophyNumberCorrect> trophiesNumberCorrect = [
    TrophyNumberCorrect(
      targetNumber: 1,
      title: "BROJ 1",
    ),
    TrophyNumberCorrect(
      targetNumber: 2,
      title: "BROJ 2",
    ),
    TrophyNumberCorrect(
      targetNumber: 3,
      title: "BROJ 3",
    ),
    TrophyNumberCorrect(
      targetNumber: 4,
      title: "BROJ 4",
    ),
    TrophyNumberCorrect(
      targetNumber: 5,
      title: "BROJ 5",
    ),
    TrophyNumberCorrect(
      targetNumber: 6,
      title: "BROJ 6",
    ),
    TrophyNumberCorrect(
      targetNumber: 7,
      title: "BROJ 7",
    ),
    TrophyNumberCorrect(
      targetNumber: 8,
      title: "BROJ 8",
    ),
    TrophyNumberCorrect(
      targetNumber: 9,
      title: "BROJ 9",
    ),
    TrophyNumberCorrect(
      targetNumber: 10,
      title: "BROJ 10",
    ),
    TrophyNumberCorrect(
      targetNumber: 11,
      title: "BROJ 11",
    ),
    TrophyNumberCorrect(
      targetNumber: 12,
      title: "BROJ 12",
    ),
  ];

  static List<Trophy> trophiesStrikes = [
    TrophyStrikes(
      targetNumber: 1,
      title: "BR 1",
    ),
    TrophyStrikes(
      targetNumber: 2,
      title: "BR 2",
    ),
    TrophyStrikes(
      targetNumber: 3,
      title: "BR 3",
    ),
    TrophyStrikes(
      targetNumber: 4,
      title: "BR 4",
    ),
    TrophyStrikes(
      targetNumber: 5,
      title: "BR 5",
    ),
    TrophyStrikes(
      targetNumber: 6,
      title: "BR 6",
    ),
    TrophyStrikes(
      targetNumber: 7,
      title: "BR 7",
    ),
    TrophyStrikes(
      targetNumber: 8,
      title: "BR 8",
    ),
    TrophyStrikes(
      targetNumber: 9,
      title: "BR 9",
    ),
    TrophyStrikes(
      targetNumber: 10,
      title: "BR 10",
    ),
    TrophyStrikes(
      targetNumber: 11,
      title: "BR 11",
    ),
    TrophyStrikes(
      targetNumber: 12,
      title: "BR 12",
    ),
  ];

  static int maxStars(List<Trophy> trphyCollection) {
    int rez = 0;
    for (var x in trphyCollection) {
      rez = rez + x.maxStars();
    }
    return rez;
  }

  static int stars(List<Trophy> trphyCollection) {
    int rez = 0;
    for (var x in trphyCollection) {
      rez = rez + x.starsCount();
    }
    return rez;
  }
}
