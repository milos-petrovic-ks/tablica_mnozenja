import 'package:flutter/material.dart';

class DisplayTaskBox extends StatelessWidget {
  final String text;
  final Color? innerColor;
  final Color? borderColor;

  const DisplayTaskBox(this.text, {super.key, this.innerColor, this.borderColor});

  Widget taskBoxContent() {
    if (text == "*") {
      return const Center(
        child: Icon(Icons.circle, size: 14, color: Colors.black),
      );
    }
    if (text == "=") {
      return const Center(
        child: Text("=",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black,
            )),
      );
    }
    return Center(
      child: Text(text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          )),
    );
  }

  BoxDecoration numberBoxDecoration(innerColor, borderColor) {
    return BoxDecoration(
        color: innerColor,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: borderColor, width: 3));
  }

  BoxDecoration signBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: Colors.grey[200] ?? Colors.grey, width: 3),
    );
  }

  bool isNumberBox() {
    if (text == "*" || text == "=") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 55.0,
      margin: const EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
            decoration:
                isNumberBox() ? numberBoxDecoration(innerColor, borderColor) : signBoxDecoration(),
            child: taskBoxContent()),
      ),
    );
  }
}
