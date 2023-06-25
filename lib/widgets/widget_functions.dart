import 'package:flutter/material.dart';

Widget addVerticalSpace(int space)
{
  return SizedBox(
      height: space.toDouble(),
       width: double.infinity,
  );
}

Widget addHorizontalSpace(int space)
{
  return SizedBox(width: space.toDouble());
}