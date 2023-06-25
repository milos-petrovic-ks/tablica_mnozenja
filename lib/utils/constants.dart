// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const COLOR_BLACK = Colors.black;
const COLOR_ORANGE = Colors.deepOrange;
const COLOR_GRAY = Color(0xff9E9E9E);
const COLOR_WHITE = Color(0xffFFA801);
const COLOR_GREEN = Color(0xff7BB655);
const GUEST_NAME = "Gost";

enum TaskBoxStatus { displayTask, correctAnswer, wrongAnswer, fixedAnswer }

TextTheme customTextTheme = TextTheme(
    headline1: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 48),
    headline2: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 40),
    headline3: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.brown),
    headline4: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.brown),
    headline5: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 20),
    headline6: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 18),
    bodyText1: GoogleFonts.nunito(fontWeight: FontWeight.normal, fontSize: 16),
    bodyText2: GoogleFonts.nunito(fontWeight: FontWeight.normal, fontSize: 14),
    subtitle1: GoogleFonts.nunito(fontWeight: FontWeight.normal, fontSize: 16),
    subtitle2: GoogleFonts.nunito(fontWeight: FontWeight.w400, fontSize: 14),
    button: GoogleFonts.nunito(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
    caption: GoogleFonts.nunito(fontWeight: FontWeight.normal, fontSize: 12));

ButtonStyle styleButtonElevatedOkGreen() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      elevation: 10,
      backgroundColor: Colors.green);
}

ButtonStyle elevatedActiveNumber() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      elevation: 8,
      backgroundColor: Colors.blue);
}

ButtonStyle elevatedNotActiveNumber() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      elevation: 8,
      backgroundColor: Colors.grey[500]);
}

ButtonStyle elevAnswerNumber() {
  Color border = Colors.blue[700] ?? Colors.blue;
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    side: BorderSide(width: 2.0, color: border),
  );
}

ButtonStyle elevAnswerDelete() {
  Color border = Colors.orange[800] ?? Colors.orange;
  return TextButton.styleFrom(
    backgroundColor: Colors.deepOrange,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    side: BorderSide(width: 2.0, color: border),
  );
}

ButtonStyle pinkElevatedButton() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      elevation: 10,
      backgroundColor: Colors.pink);
}

ButtonStyle blueElevatedButton() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    elevation: 3,
  );
}

ButtonStyle disabledBlueElevatedButton() {
  return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      elevation: 3,
      backgroundColor: Colors.grey);
}

ButtonStyle orangeElevButton() {
  Color border = Colors.orange[500] ?? Colors.orange;
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.orange[400],
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    side: BorderSide(width: 3.0, color: border),
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    elevation: 3,
  );
}
