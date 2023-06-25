import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/widgets/alert_dialogs.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';
import '../widgets/widget_functions.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final List<Color?> statColors = [
    Colors.grey[300],
    Colors.deepOrange,
    Colors.amber,
    Colors.green[200],
    Colors.green
  ];

  void clearAllStats() {
    setState(() {
      Globals.loggedPerson.resetUserStatistics();
    });
  }

  String zadtakDetails = "--";
  String tacnihDetails = "--";
  String pogresnihDetails = "--";
  String procDetails = "--";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tableCellW = (width * 0.9 / 5).round().toDouble();
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            addVerticalSpace(30),
            DataTable(
              border: TableBorder.all(width: 2.0, color: Colors.grey),
              columnSpacing: 30,
              dataRowHeight: 35,
              headingRowHeight: 35,
              dataTextStyle: Theme.of(context).textTheme.headline6,
              columns: <DataColumn>[
                DataColumn(
                  label: Text("br. tačnih", style: Theme.of(context).textTheme.headline6),
                ),
                DataColumn(
                  label: Text("br. netačnih", style: Theme.of(context).textTheme.headline6),
                ),
                DataColumn(
                  label: Text("ukupno", style: Theme.of(context).textTheme.headline6),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(Globals.loggedPerson.totalCorrect().toString(),
                            style: const TextStyle(color: Colors.green)))),
                    DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(Globals.loggedPerson.totalIncorrect().toString(),
                            style: const TextStyle(color: Colors.red)))),
                    DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(Globals.loggedPerson.totalAttempts().toString()))),
                  ],
                ),
              ],
            ),
            addVerticalSpace(10),
            const Text(
              "pritisni polje u tabeli da bi video detalje",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 13,
                  children: List.generate(169, (index) {
                    return gridViewTile(index);
                  }),
                )),
            meaningOfColors(),
            DataTable(
              columnSpacing: 0,
              dataRowHeight: 35,
              headingRowHeight: 35,
              dataTextStyle: Theme.of(context).textTheme.headline6,
              columns: <DataColumn>[
                DataColumn(
                  label: Text("", style: Theme.of(context).textTheme.headline6),
                ),
                DataColumn(
                  label: SizedBox(
                    width: tableCellW,
                    child: const Icon(
                      Icons.thumb_up_alt_rounded,
                      size: 26,
                      color: Color.fromARGB(255, 30, 140, 87),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: tableCellW,
                    child: const Icon(
                      Icons.thumb_down_alt_rounded,
                      size: 26,
                      color: Colors.red,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: tableCellW,
                    child: const Icon(
                      Icons.percent,
                      size: 28,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      SizedBox(
                        width: tableCellW,
                        child: Text(
                          zadtakDetails,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: tableCellW,
                        alignment: Alignment.center,
                        child: Text(tacnihDetails),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: tableCellW,
                        alignment: Alignment.center,
                        child: Text(pogresnihDetails),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: tableCellW,
                        alignment: Alignment.center,
                        child: Text(procDetails),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            addVerticalSpace(40),
            ElevatedButton(
                style: pinkElevatedButton(),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return confirmChangesDialog(context, 'Brisanje Statistike',
                            'Da li želiš da obrišeš sve svoje rezultate.', clearAllStats);
                      });
                },
                child: const Text("obriši sve rezultate")),
            addVerticalSpace(50),
          ],
        ),
      ),
    );
  }

  Widget gridViewTile(int index) {
    String text = "";
    if (index == 0) {
      text = " ";
    }
    if (index < 13 && index > 0) {
      text = index.toString();
    }
    if (index % 13 == 0 && index > 12) {
      text = ((index / 13)).round().toString();
    }
    if (text.isNotEmpty) {
      return Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.blue[100],
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    int row = (index / 13).floor() - 1;
    int column = (index - 13 * (row + 1) - 1).round();
    int indexFix = 12 * row + column;
    text = Globals.loggedPerson.attempts[indexFix].toString();
    int brojTacnih = Globals.loggedPerson.numCorrect[indexFix];
    int brojPokusaja = Globals.loggedPerson.attempts[indexFix];
    int procCorrect = Globals.loggedPerson.attempts[indexFix] == 0
        ? -1
        : (brojTacnih / brojPokusaja * 100).round();
    return GestureDetector(
      child: Container(color: percentageCorrectToStatsColor(procCorrect)),
      onTap: () {
        setState(() {
          int num1 = row + 1;
          int num2 = column + 1;
          zadtakDetails = "$num1 * $num2";
          tacnihDetails = brojTacnih.toString();
          pogresnihDetails = (brojPokusaja - brojTacnih).toString();
          procDetails = procCorrect == -1 ? "--" : procCorrect.toString();
        });
      },
    );
  }

  Widget meaningOfColors() {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Table(
          children: [
            TableRow(children: [
              singleColorMeaning(1),
              singleColorMeaning(2),
              singleColorMeaning(3),
              singleColorMeaning(4)
            ])
          ],
        ));
  }

  Widget singleColorMeaning(int colorIndex) {
    List<String> texts = ["loše", "srednje", "dobro", "odlično"];
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(7, 5, 10, 5),
              width: 15,
              height: 15,
              color: statColors[colorIndex]),
          Text(
            texts[colorIndex - 1],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ]);
  }

  Color percentageCorrectToStatsColor(int? procCorrect) {
    Color? currColor = statColors[0];
    if (procCorrect != null) {
      if (procCorrect > -1) {
        currColor = statColors[1];
      }
      if (procCorrect > 50) {
        currColor = statColors[2];
      }
      if (procCorrect > 80) {
        currColor = statColors[3];
      }
      if (procCorrect > 95) {
        currColor = statColors[4];
      }
    }
    return currColor ?? Colors.blue;
  }
}
