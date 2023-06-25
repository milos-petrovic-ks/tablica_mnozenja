import 'package:flutter/material.dart';

abstract class Trophy {
  String imageTemplate;
  String title;
  String? explanation;
  Trophy({required this.imageTemplate, required this.title, this.explanation});
  Widget display(double pageWidth);
  int starsCount();
  int maxStars();
}
