import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/widgets/alert_dialogs.dart';
import '../models/person.dart';
import '../screens/wrapper_screen.dart';
import '../services/auth.dart';
import '../widgets/appbar_widget.dart';
import '../services/database.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';
import '../widgets/widget_functions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
// State<Settings> createState() => _SettingsState(RangeValues(person.minFirst.toDouble(), person.maxFirst.toDouble()));
}

class _SettingsState extends State<Settings> {
  RangeLabels? labelsFirst;
  bool isSwitched = false;
  bool isShowCorrectAnswer = false;

  _SettingsState();

  void submitSettings() {
    setState(() {});
    DatabaseService().updatePersonToDatabase(Globals.loggedPerson);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    isSwitched = Globals.loggedPerson.sound;
    isShowCorrectAnswer = Globals.loggedPerson.showCorrectAnswer;
  }

  @override
  void dispose() async {
    super.dispose();
    DatabaseService().updatePersonToDatabase(Globals.loggedPerson);
  }

  void toggleSoundSwitch(bool value) {
    setState(() {
      Globals.loggedPerson.sound = !Globals.loggedPerson.sound;
      isSwitched = !isSwitched;
    });
  }

  void toggleShowAnswer(bool value) {
    setState(() {
      Globals.loggedPerson.showCorrectAnswer = !Globals.loggedPerson.showCorrectAnswer;
      isShowCorrectAnswer = !isShowCorrectAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        text: "Podešavanja",
        isLogOutButton: false,
        hasTabs: false,
        isLevel2: true,
      ),
      body: Column(
        children: <Widget>[
          addVerticalSpace(60),
          Text("Podešavanja", style: Theme.of(context).textTheme.headline3),
          addVerticalSpace(20),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white30,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Row(
              children: [
                Expanded(
                    flex: 7,
                    child: Text(
                      "zvuk",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.left,
                    )),
                Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(onChanged: toggleSoundSwitch, value: isSwitched),
                    )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white30,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Row(
              children: [
                Expanded(
                    flex: 7,
                    child: Text(
                      "pokaži tačan odgovor",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.left,
                    )),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(onChanged: toggleShowAnswer, value: isShowCorrectAnswer),
                  ),
                ),
              ],
            ),
          ),
          addVerticalSpace(20),
          ElevatedButton(
            style: styleButtonElevatedOkGreen(),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
          addVerticalSpace(150),
          ElevatedButton(
              style: pinkElevatedButton(),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      if (Person.isGuestPerson(Globals.loggedPerson)) {
                        return errorMessageDialog(context, "Gost ne može da se obriše");
                      } else {
                        return showAlertDialog();
                      }
                    });
              },
              child: const Text("OBRIŠI NALOG"))
        ],
      ),
    );
  }

  AlertDialog showAlertDialog() {
    return AlertDialog(
      title: const Text('Brisanje korisnika'),
      content: const Text('Da li želiš da obrišeš svoj nalog.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () async {
            await Authentication().deleteCurrentUser();
            // await Authentication().signOut();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Wrapper(
                  loggedInAsGuest: false,
                ),
              ),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
