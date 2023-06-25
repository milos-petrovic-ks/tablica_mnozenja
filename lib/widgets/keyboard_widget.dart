import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/utils/constants.dart';

class Keyboard extends StatelessWidget {
  final Function(String) callback;

  const Keyboard(this.callback, {super.key});

  Widget listButton(String text) {
    Widget child = text == "D"
        ? const Icon(Icons.delete)
        : FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
    return ElevatedButton(
        style: text == "D" ? elevAnswerDelete() : elevAnswerNumber(),
        onPressed: () {
          callback(text);
        },
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1 / 1,
        crossAxisCount: 5,
        children: [
          listButton("0"),
          listButton("1"),
          listButton("2"),
          listButton("3"),
          listButton("4"),
          listButton("5"),
          listButton("6"),
          listButton("7"),
          listButton("8"),
          listButton("9"),
          const Text(""),
          const Text(""),
          listButton("D"),
        ],
      ),
    );
  }
}
