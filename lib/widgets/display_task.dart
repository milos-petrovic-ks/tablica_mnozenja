import 'package:flutter/material.dart';
import 'display_task_box_img.dart';
import '../utils/constants.dart';

class DisplayTask extends StatelessWidget {
  final int firstFactor;
  final int secondFactor;
  final String currentUserAnswer;
  final TaskBoxStatus leftStatus;
  final TaskBoxStatus rightStatus;

  const DisplayTask(this.firstFactor, this.secondFactor, this.currentUserAnswer, this.leftStatus,
      this.rightStatus,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DisplayTaskBoxImg(
              text: firstFactor.toString(), isAnswerText: false, rightStatus: rightStatus),
          DisplayTaskBoxImg(text: "*", isAnswerText: false, rightStatus: rightStatus),
          DisplayTaskBoxImg(
              text: secondFactor.toString(), isAnswerText: false, rightStatus: rightStatus),
          DisplayTaskBoxImg(text: "=", isAnswerText: false, rightStatus: rightStatus),
          DisplayTaskBoxImg(text: currentUserAnswer, isAnswerText: true, rightStatus: rightStatus),
        ],
      ),
    );
  }
}
