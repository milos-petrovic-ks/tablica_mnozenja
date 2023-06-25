import 'package:flutter/cupertino.dart';

class Common {
  static void toConsole(String s, {String? title}) {
    debugPrint(title == null ? s : "$title = $s");
  }
}
