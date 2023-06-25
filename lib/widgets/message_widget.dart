import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart';
import 'widget_functions.dart';

bool messageWidget(context, firstFactor, secondFactor) {
  AudioPlayer player = AudioPlayer();
  int correctFac1 = Globals.loggedPerson.correctAnswersPerNumber(firstFactor);
  int correctFac2 = Globals.loggedPerson.correctAnswersPerNumber(secondFactor);
  int strikesFac1 = Globals.loggedPerson.strikes[firstFactor - 1];
  int strikesFac2 = Globals.loggedPerson.strikes[firstFactor - 1];
  bool hasMessage = false;

  List<int> boundsCorrect = Globals.numberCorrectBadgeBounds;
  List<int> boundsStrikes = Globals.strikestBadgeBounds;
  String message1 = "";
  String message2 = "";
  Color border = const Color.fromARGB(255, 192, 145, 6);
  Color background = const Color.fromARGB(255, 237, 194, 64);
  Icon punaZvezda = const Icon(
    Icons.star,
    color: Colors.white,
    size: 24,
  );
  Icon praznaZvezda = const Icon(
    Icons.star_border,
    color: Colors.white,
    size: 24,
  );
  List<Icon> stars = [punaZvezda, praznaZvezda, praznaZvezda];

  for (int i = 0; i < boundsCorrect.length; i++) {
    if (correctFac1 == boundsCorrect[i] || correctFac2 == boundsCorrect[i]) {
      int numForBadge = correctFac1 == boundsCorrect[i] ? firstFactor : secondFactor;
      if (i == 0) {
        message1 = "BROJ $numForBadge";
        message2 = "Treća nagrada za tačne odgovore.";
      }
      if (i == 1) {
        message1 = "BROJ $numForBadge";
        message2 = "Druga nagrada za tačne odgovore.";
        border = Colors.blue;
        background = Colors.blue.shade300;
        stars[1] = punaZvezda;
      }
      if (i == 2) {
        message1 = "BROJ $numForBadge";
        message2 = "Prva nagrada za tačne odgovore.";
        border = const Color.fromARGB(255, 192, 145, 6);
        background = const Color.fromARGB(255, 237, 194, 64);
        stars[1] = punaZvezda;
        stars[2] = punaZvezda;
      }
    }
  }

  for (int i = 0; i < boundsCorrect.length; i++) {
    if (strikesFac1 == boundsStrikes[i] || strikesFac2 == boundsStrikes[i]) {
      int numForStrike = correctFac1 == boundsStrikes[i] ? firstFactor : secondFactor;
      if (i == 0) {
        message1 = "BROJ $numForStrike";
        message2 = "COMBO !! - treća nagrada";
      }
      if (i == 1) {
        message1 = "BROJ $numForStrike";
        message2 = "COMBO !! - druge nagrada";
        border = Colors.blue;
        background = Colors.blue.shade300;
        stars[1] = punaZvezda;
      }
      if (i == 2) {
        message1 = "BROJ $numForStrike";
        message2 = "COMBO !! - prva nagrada";
        border = const Color.fromARGB(255, 192, 145, 6);
        background = const Color.fromARGB(255, 237, 194, 64);
        stars[1] = punaZvezda;
        stars[2] = punaZvezda;
      }
    }
  }

  if (message1 != "" && message2 != "") {
    hasMessage = true;
    if (Globals.loggedPerson.sound) {
      player.play(AssetSource("achivement2.mp3"));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 10, 0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: border,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            color: background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    message1,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                    height: 10,
                  ),
                  stars[0],
                  const SizedBox(
                    width: 5,
                    height: 10,
                  ),
                  stars[1],
                  const SizedBox(
                    width: 5,
                    height: 10,
                  ),
                  stars[2],
                ],
              ),
              addVerticalSpace(15),
              Text(
                message2,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      elevation: 3,
                    ),
                    child: const Text(
                      "OK",
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 300,
        ),
      ),
    );
  }
  return hasMessage;
}
