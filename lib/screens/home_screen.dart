import 'package:flutter/material.dart';
import '../screens/tab_navigation_screen.dart';
import '../utils/globals.dart';
import '../utils/constants.dart';
import '../widgets/widget_functions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _goToPractice() {
    Globals.showPracticeScreen = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TabNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Globals.loggedPerson.numbersToPractice.isEmpty) {
      // Globals.loggedPerson.numbersToPractice = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    }
    bool buttonIsDisabled = Globals.loggedPerson.numbersToPractice.isEmpty;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: Text("Zdravo ${Globals.loggedPerson.name}",
              style: Theme.of(context).textTheme.headline3),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 35),
          child: Text(
            "Izaberi brojeve sa kojima ćes da vežbaš.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
            width: 380,
            height: 220,
            child: GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 18.0,
              childAspectRatio: 1 / 1,
              crossAxisCount: 4,
              children: [
                _buttonWithNumbers(1),
                _buttonWithNumbers(2),
                _buttonWithNumbers(3),
                _buttonWithNumbers(4),
                _buttonWithNumbers(5),
                _buttonWithNumbers(6),
                _buttonWithNumbers(7),
                _buttonWithNumbers(8),
                _buttonWithNumbers(9),
                _buttonWithNumbers(10),
                _buttonWithNumbers(11),
                _buttonWithNumbers(12)
              ],
            )),
        addVerticalSpace(40),
        SizedBox(
          width: 380,
          child: GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 7 / 2,
            crossAxisCount: 1,
            children: [
              ElevatedButton(
                style: buttonIsDisabled ? disabledBlueElevatedButton() : blueElevatedButton(),
                onPressed: () {
                  if (!buttonIsDisabled) {
                    _goToPractice();
                  }
                },
                child: const Text("OK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 2,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }

  ElevatedButton _buttonWithNumbers(int number) {
    return ElevatedButton(
        style: Globals.loggedPerson.isNumInListToPractice(number)
            ? elevatedActiveNumber()
            : elevatedNotActiveNumber(),
        onPressed: () => setState(() {
              Globals.loggedPerson.updateNumbersToPractice(number);
            }),
        child: Text(number.toString()));
  }
}
