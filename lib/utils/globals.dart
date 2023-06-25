import 'package:flutter/material.dart';
import '../models/person.dart';

class Globals {
  static Person loggedPerson = Person.createEmptyPerson();
  static bool showPracticeScreen = false;
  static List<double> rankBoundsTab1 = [20, 40, 70, 90];
  static List<double> rankBoundsTab2 = [20, 70, 80, 90];
  static List<int> numberCorrectBadgeBounds = [2, 5, 10];
  static List<int> strikestBadgeBounds = [2, 5, 10];
  static bool waitForAnimation = false;
  static Map<String, Color> tileColors(String levelStr) {
    if (levelStr == "GOLD") {
      return {
        "back": const Color.fromARGB(255, 238, 211, 113),
        "border": const Color.fromARGB(255, 189, 189, 189),
        "star_border": Colors.blue,
        "line_dark": Colors.blue,
        "line_light": const Color.fromARGB(50, 150, 150, 150),
      };
    }

    if (levelStr == "SILV") {
      return {
        "back": const Color.fromARGB(255, 255, 248, 222),
        "border": Colors.amber[200] ?? Colors.amber,
        "star_border": const Color.fromARGB(255, 220, 166, 3),
        "line_dark": const Color.fromARGB(255, 248, 206, 80),
        "line_light": const Color.fromARGB(255, 251, 239, 205),
      };
    }

    if (levelStr == "BRON") {
      return {
        "back": const Color.fromARGB(255, 250, 226, 187),
        "border": const Color.fromARGB(255, 215, 137, 160),
        "star_border": const Color.fromARGB(255, 147, 88, 30),
        "line_dark": const Color.fromARGB(255, 184, 116, 48),
        "line_light": const Color.fromARGB(80, 184, 116, 48),
      };
    }
    return {
      "back": const Color.fromARGB(255, 250, 250, 250),
      "border": const Color.fromARGB(255, 190, 188, 188),
      "star_border": const Color.fromARGB(255, 141, 141, 141),
      "line_dark": const Color.fromARGB(255, 200, 200, 200),
      "line_light": const Color.fromARGB(120, 200, 200, 200),
    };
  }
}
