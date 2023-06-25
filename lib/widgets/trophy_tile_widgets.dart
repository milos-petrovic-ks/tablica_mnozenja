import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../utils/globals.dart';

class TrophyTile {
  static Row _levelStars(int level, List<String> levelsStr) {
    return Row(
      children: [
        Icon(
          level > 0 ? Icons.star_rate : Icons.star_outline,
          color: Globals.tileColors(levelsStr[level])["star_border"],
          size: 26,
        ),
        Icon(
          level > 1 ? Icons.star_rate : Icons.star_outline,
          color: Globals.tileColors(levelsStr[level])["star_border"],
          size: 26,
        ),
        Icon(
          level > 2 ? Icons.star_rate : Icons.star_outline,
          color: Globals.tileColors(levelsStr[level])["star_border"],
          size: 26,
        ),
      ],
    );
  }

  static Widget trophieTile(
    double width,
    List<String> levelsNames,
    int level,
    String imgSource,
    String title,
    double percentageDone,
    String textInBar,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: Globals.tileColors(levelsNames[level])["back"],
        border: Border.all(
          width: 2,
          color: Globals.tileColors(levelsNames[level])["border"] ?? Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(imgSource),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                            letterSpacing: 1,
                          ),
                        ),
                        TrophyTile._levelStars(level, levelsNames)
                      ],
                    ),
                    LinearPercentIndicator(
                      animation: false,
                      animationDuration: 1000,
                      lineHeight: 24.0,
                      percent: percentageDone,
                      center: Text(
                        textInBar,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      barRadius: const Radius.circular(5),
                      progressColor: Globals.tileColors(levelsNames[level])["line_dark"],
                      backgroundColor: Globals.tileColors(levelsNames[level])["line_light"],
                      padding: const EdgeInsets.all(0),
                      alignment: MainAxisAlignment.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
