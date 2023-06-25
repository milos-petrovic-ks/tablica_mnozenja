import 'dart:math';
import 'package:tablica_mnozenja/services/device_id.dart';
import 'package:tablica_mnozenja/utils/constants.dart';

class Person {
  final String deviceId = DeviceId.deviceId;
  String uid = "";
  String name = "";
  String email = "";
  String error = "";
  List<int> attempts = List.generate(144, (index) => 0);
  List<int> numCorrect = List.generate(144, (index) => 0);
  List<int> numbersToPractice = [];
  List<int> strikes = List.generate(12, (index) => 0);
  List<int> maxStrikes = List.generate(12, (index) => 0);
  static int maxNumberToPractice = 12;
  bool sound = true;
  bool showCorrectAnswer = true;

  Person(this.uid, this.name, String email) {
    this.email = "$name@${DeviceId.getDomainName()}.com";
    numbersToPractice = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  }

  void changeSound() {
    sound = !sound;
  }

  void changeShowCorrectAnswer() {
    showCorrectAnswer = !showCorrectAnswer;
  }

  static Person createGuestPerson() {
    return Person("", GUEST_NAME, "");
  }

  static Person createEmptyPerson() {
    return Person("", "", "");
  }

  static bool isGuestPerson(Person p) {
    return p.name == GUEST_NAME;
  }

  static bool isEmptyPerson(Person p) {
    return p.name == "";
  }

  static Person createErrorPerson(String error) {
    Person p = Person("", "", "");
    p.error = error;
    return p;
  }

  bool isErrorPerson() {
    return error.isNotEmpty;
  }

  Person.all(
    this.uid,
    this.name,
    this.email,
    String attemptsStr,
    String correctStr,
    String numbersToPracticeStr,
    String strikesStr,
    String maxStrikesStr,
    this.sound,
    this.showCorrectAnswer,
  ) {
    attempts = fromStringToList(attemptsStr);
    numCorrect = fromStringToList(correctStr);
    numbersToPractice = fromStringToList(numbersToPracticeStr);
    strikes = fromStringToList(strikesStr);
    maxStrikes = fromStringToList(maxStrikesStr);
    setMaxNumberToPractice();
  }

  @override
  String toString() {
    String rez =
        "uid = $uid, name = $name, numbersToPractice = ${numbersToPracticeToString()}, sound = $sound";
    return rez;
  }

  // LIST TO STRING AND BACK - START
  List<int> fromStringToList(String strArr) {
    List<int> result = [];
    if (strArr == "") {
      return [];
    }

    List<String> strArrSplit = strArr.split("|");
    for (var i = 0; i < strArrSplit.length; i++) {
      result.add(int.parse(strArrSplit[i]));
    }
    return result;
  }

  String _listOfNumbersToString(List<int> numbers) {
    if (numbers.isEmpty) {
      return "";
    }
    return numbers.join('|');
  }

  String attemptsToSting() {
    return _listOfNumbersToString(attempts);
  }

  String numCorrectToSting() {
    return _listOfNumbersToString(numCorrect);
  }

  String numbersToPracticeToString() {
    return _listOfNumbersToString(numbersToPractice);
  }

  String strikesToString() {
    return _listOfNumbersToString(strikes);
  }

  String maxStrikesToString() {
    return _listOfNumbersToString(maxStrikes);
  }

  String practiceNumbersSentence() {
    String listOfNumbersDesc = "";
    if (numbersToPractice.last - numbersToPractice.first == numbersToPractice.length - 1) {
      if (numbersToPractice.last == numbersToPractice.first) {
        listOfNumbersDesc = numbersToPractice.first.toString();
      }
      if (numbersToPractice.last - numbersToPractice.first == 1) {
        listOfNumbersDesc =
            "${numbersToPractice.first.toString()} i ${numbersToPractice.last.toString()}";
      }
      if (numbersToPractice.last - numbersToPractice.first > 1) {
        listOfNumbersDesc = "od ${numbersToPractice.first} do ${numbersToPractice.last}";
      }
    } else {
      String delimit = "";
      for (var i = 0; i < numbersToPractice.length; i++) {
        delimit = i < numbersToPractice.length - 1 ? ", " : " i ";
        if (i == 0) {
          delimit = "";
        }
        listOfNumbersDesc = listOfNumbersDesc + delimit + numbersToPractice[i].toString();
      }
    }

    String brojeveStr = numbersToPractice.length == 1 ? "broj" : "brojeve";
    return "vežbamo $brojeveStr \n $listOfNumbersDesc";
  }

  // NUMBERS TO PRACTICE
  void setAllToPractice() {
    setIntervalToPractice(1, maxNumberToPractice);
  }

  void setIntervalToPractice(int start, int end) {
    numbersToPractice = [];
    for (var i = start; i <= end; i++) {
      updateNumbersToPractice(i);
    }
  }

  void setFixedNumberToPractice(int num) {
    numbersToPractice = [];
    updateNumbersToPractice(num);
  }

  void updateNumbersToPractice(int num) {
    if (num < 1 || num > 12) {
      return;
    }

    if (numbersToPractice.contains(num)) {
      numbersToPractice.remove(num);
    } else {
      numbersToPractice.add(num);
    }
    numbersToPractice.sort();
  }

  bool isNumInListToPractice(int num) {
    return numbersToPractice.contains(num);
  }

  // <<< TRIANGULAR INDEX
  List<int> getFactorsFromTriangularIndex(int index) {
    if (index < 0 || index > 77) {
      return [-1, -1];
    }
    index = index + 1;
    int firstFactor = 1;
    int lenThisRow = 1;
    while (index > lenThisRow) {
      index = index - lenThisRow;
      firstFactor = firstFactor + 1;
      lenThisRow = lenThisRow + 1;
    }
    int secondFactor = index;

    return [firstFactor, secondFactor];
  }

  String getMultStringFromTriangularIndex(index) {
    int factor1 = getFactorsFromTriangularIndex(index)[0];
    int factor2 = getFactorsFromTriangularIndex(index)[1];
    return "$factor1 * $factor2";
  }

  int correctAnswersPerNumber(int num) {
    int firstNum = 1;
    int secondNum = 1;
    int rez = 0;
    for (var i = 0; i < numCorrect.length; i++) {
      firstNum = getFirstFactorFromArrayIndex(i);
      secondNum = getSecondFactorFromArrayIndex(i);
      if (firstNum == num || secondNum == num) {
        rez = rez + numCorrect[i];
      }
    }
    return rez;
  }

  String getCorrectWrongFromTriangularIndex(index) {
    int factor1 = getFactorsFromTriangularIndex(index)[0];
    int factor2 = getFactorsFromTriangularIndex(index)[1];
    int arrayIndex1 = getArrayIndexFromFactors(factor1, factor2);
    int arrayIndex2 = getArrayIndexFromFactors(factor2, factor1);
    int totalCorrect = factor1 == factor2
        ? numCorrect[arrayIndex1]
        : numCorrect[arrayIndex1] + numCorrect[arrayIndex2];
    int totalDone =
        factor1 == factor2 ? attempts[arrayIndex1] : attempts[arrayIndex1] + attempts[arrayIndex2];
    return "$totalCorrect / $totalDone";
  }

  int? getPercentageCorrectFromTriangularIndex(index) {
    int factor1 = getFactorsFromTriangularIndex(index)[0];
    int factor2 = getFactorsFromTriangularIndex(index)[1];
    int arrayIndex1 = getArrayIndexFromFactors(factor1, factor2);
    int arrayIndex2 = getArrayIndexFromFactors(factor2, factor1);
    int totalCorrect = factor1 == factor2
        ? numCorrect[arrayIndex1]
        : numCorrect[arrayIndex1] + numCorrect[arrayIndex2];
    int totalDone =
        factor1 == factor2 ? attempts[arrayIndex1] : attempts[arrayIndex1] + attempts[arrayIndex2];
    if (totalDone == 0) {
      return null;
    }
    return ((totalCorrect / totalDone) * 100).round();
  }

  String getPercentageCorrectStrFromTriangularIndex(index) {
    int? p = getPercentageCorrectFromTriangularIndex(index);
    if (p == null) {
      return "";
    }
    return "${p.toString()} %";
  }

  // INCREMENT DECREMENT
  void incrementAttempts(int fac1, int fac2) {
    if (fac1 < 1 || fac1 > 12 || fac2 < 1 || fac2 > 12) {
      return;
    }
    attempts[12 * (fac1 - 1) + fac2 - 1] = attempts[12 * (fac1 - 1) + fac2 - 1] + 1;
  }

  void incrementNumCorrect(int fac1, int fac2) {
    if (fac1 < 1 || fac1 > 12 || fac2 < 1 || fac2 > 12) {
      return;
    }
    numCorrect[12 * (fac1 - 1) + fac2 - 1] = numCorrect[12 * (fac1 - 1) + fac2 - 1] + 1;
  }

  void incrementStrikes(int fac1, int fac2) {
    if (fac1 < 1 || fac1 > 12 || fac2 < 1 || fac2 > 12) {
      return;
    }
    strikes[fac1 - 1] = strikes[fac1 - 1] + 1;
    if (fac1 != fac2) {
      strikes[fac2 - 1] = strikes[fac2 - 1] + 1;
    }
    for (int i = 0; i < strikes.length; i++) {
      if (strikes[i] > maxStrikes[i]) {
        maxStrikes[i] = strikes[i];
      }
    }
  }

  void resetStrikes(int fac1, int fac2) {
    if (fac1 < 1 || fac1 > 12 || fac2 < 1 || fac2 > 12) {
      return;
    }
    strikes[fac1 - 1] = 0;
    strikes[fac2 - 1] = 0;
  }

  int totalAttempts() {
    return attempts.reduce((a, b) => a + b);
  }

  int totalCorrect() {
    return numCorrect.reduce((a, b) => a + b);
  }

  int totalIncorrect() {
    return totalAttempts() - totalCorrect();
  }

  int getFirstFactorFromArrayIndex(int index) {
    return ((index - index % 12) / 12).round() + 1;
  }

  int getSecondFactorFromArrayIndex(int index) {
    return index % 12 + 1;
  }

  int getArrayIndexFromFactors(int factor1, int factor2) {
    return 12 * (factor1 - 1) + factor2 - 1;
  }

  void resetUserStatistics() {
    attempts = List.generate(144, (index) => 0);
    numCorrect = List.generate(144, (index) => 0);
    strikes = List.generate(12, (index) => 0);
    maxStrikes = List.generate(12, (index) => 0);
  }

  List<int> getMultiplicationTask() {
    Random rnd = Random();
    if (numbersToPractice.isEmpty) {
      setAllToPractice();
    }
    List<int> secondNumbersToPractice = List<int>.generate(maxNumberToPractice, (n) => n + 1);
    List<Map> possibleCombinations = <Map>[];

    for (var i in numbersToPractice) {
      for (var j in secondNumbersToPractice) {
        possibleCombinations.add(createMapFromIndexes(i, j));
        if (i != j) {
          possibleCombinations.add(createMapFromIndexes(j, i));
        }
      }
    }
    possibleCombinations.shuffle();
    possibleCombinations.sort((a, b) => a["SCORE"] < b["SCORE"] ? -1 : 1);
    int randomLimit = min(possibleCombinations.length, 4);
    int randomIndex = rnd.nextInt(randomLimit);
    int first = int.parse(possibleCombinations[randomIndex]["F1"].toString());
    int second = int.parse(possibleCombinations[randomIndex]["F2"].toString());
    return [first, second];
  }

  String printPossibleCombinations(List<Map> possibleComb) {
    String rez = "";
    for (var m in possibleComb) {
      rez =
          "$rez ${m["F1"].toString()}*${m["F2"].toString()} ${m["COR"].toString()}/${m["AT"].toString()} = ${m["SCORE"].toString()}|";
    }
    return rez;
  }

  Map createMapFromIndexes(int i, int j) {
    int maxAttempts = attempts.reduce(max);
    int minAttempts = attempts.reduce(min);
    var map = {};
    map['F1'] = i;
    map['F2'] = j;
    map['AT'] = attempts[getArrayIndexFromFactors(i, j)];
    map['COR'] = numCorrect[getArrayIndexFromFactors(i, j)];
    int percentCorrect = map['AT'] == 0 ? 0 : (map['COR'] / map['AT'] * 100).round();
    int scaleNumberOfAttempts = maxAttempts == 0
        ? 0
        : ((map['AT'] - minAttempts) / (maxAttempts - minAttempts) * 60).round();
    map["SCORE"] = percentCorrect + scaleNumberOfAttempts;
    return map;
  }

  void setMaxNumberToPractice() {
    maxNumberToPractice = 10;
    if (numbersToPractice.isNotEmpty) {
      maxNumberToPractice = numbersToPractice.reduce(max) > 10 ? 12 : 10;
    }
  }

  Person.fromJson(Map<String, dynamic> parsedJSON)
      : uid = parsedJSON['uid'],
        name = parsedJSON['name'],
        email = parsedJSON['email'];
}
