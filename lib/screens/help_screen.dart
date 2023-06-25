import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/utils/constants.dart';
import '../services/database.dart';
import '../utils/globals.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/widget_functions.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  RangeLabels? labelsFirst;
  bool isSwitched = false;
  bool isShowCorrectAnswer = false;

  _HelpScreenState();

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
    TextStyle ts = const TextStyle(
      fontSize: 18,
    );
    return Scaffold(
      appBar: AppBarCommon(
        text: "Pomoć",
        isLogOutButton: false,
        hasTabs: false,
        isLevel2: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: <Widget>[
              addVerticalSpace(40),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''Ovaj program je namenjen svoj deci koja žele da brzo i efikasno nauče tablicu množenja.''',
                      style: ts,
                    ),
                    addVerticalSpace(20),
                    Text(
                      '''Praksa je pokazala da je dovoljino 15 do 20 minuta dnevno kako bi svako dete u roku od 15 dana savladalo i nejteže primere''',
                      style: ts,
                    ),
                    addVerticalSpace(30),
                    Text(
                      '''Neke od glavnih osobina programa su:''',
                      style: ts.copyWith(fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(10),
                    Text(
                      '''1. Učenik sam bira brojeve sa kojima će da vežba (preporuka je da se počne sa 
lakšim brojevima kao što su 1, 2, 5 i 10 a zatim da se pređe na teže primere).''',
                      style: ts,
                    ),
                    addVerticalSpace(20),
                    Text(
                      '''2. Program češće zadaje primere na kojema je dete više grešilo (na taj način će dete brže svaladava najteže primere).''',
                      style: ts,
                    ),
                    addVerticalSpace(20),
                    Text(
                      '''3. Roditelj ili učitelj u svakom trenutku može da vidi broj urađenih zadatatak kao pregled tačnio i netačno urađenih primera.''',
                      style: ts,
                    ),
                    addVerticalSpace(20),
                    Text(
                      '''4. Dete tokom rada osvaja pehare i trofeje što ga motiviše da nastavi sa radom a takođe dobija povratnu informaciju o postignutom napredku.''',
                      style: ts,
                    ),
                    addVerticalSpace(20),
                    Text(
                      '''5. Više deteta može da radi zadatake na istom telefonu.''',
                      style: ts,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(50),
              ElevatedButton(
                style: styleButtonElevatedOkGreen(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
              addVerticalSpace(100),
            ],
          ),
        ),
      ),
    );
  }
}
