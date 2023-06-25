import 'package:flutter/material.dart';
import 'widget_functions.dart';

class ScoreInPracticeWidget extends StatelessWidget {
  final int numCorrect;
  final int numWrong;

  const ScoreInPracticeWidget(this.numCorrect, this.numWrong, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: const Icon(
                    Icons.thumb_up_alt_rounded,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Text(numCorrect.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )),
              ],
            ),
          ),
          addHorizontalSpace(15),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: const Icon(
                      Icons.thumb_down_alt_rounded,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                  Text(
                    numWrong.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              )),
        ]));
  }
}
