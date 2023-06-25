import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/utils/constants.dart';

class DisplayTaskBoxImg extends StatelessWidget {
  final String text;
  final bool isAnswerText;
  final TaskBoxStatus rightStatus;

  const DisplayTaskBoxImg(
      {required this.text, required this.isAnswerText, required this.rightStatus, super.key});

  Widget taskBoxContent() {
    if (text == "*") {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/puta.png"),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (text == "=") {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/=.png"),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    double scaleImage = 3.8;
    String firstFileName = text.isNotEmpty ? text[0] : "empty";
    String secondFileName = text.length == 2 ? text[1] : "";
    if (secondFileName == "" && isAnswerText) {
      secondFileName = "empty";
    }
    String redStr = rightStatus == TaskBoxStatus.wrongAnswer && isAnswerText ? "red" : "";

    Container firstLetterCont = Container(
      width: 171 / scaleImage,
      height: 297 / scaleImage,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/$redStr$firstFileName.png"),
          fit: BoxFit.contain,
        ),
      ),
    );

    Container secondLetterCont = secondFileName == ""
        ? Container(
            width: 0,
            height: 0,
            color: Colors.white,
          )
        : Container(
            width: 171 / scaleImage,
            height: 297 / scaleImage,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/$redStr$secondFileName.png"),
                fit: BoxFit.contain,
              ),
            ),
          );

    return Row(
      children: [firstLetterCont, secondLetterCont],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: taskBoxContent(),
    );
  }
}
