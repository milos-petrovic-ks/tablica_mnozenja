import 'package:tablica_mnozenja/models/person.dart';

class LongOpertions {
  static Future<Person> slowFirebaseInitializeApp() async {
    await Future.delayed(const Duration(seconds: 10));
    return Person.createErrorPerson(
        "Ne mogu da se povežem sa bazom podataka. Proveri internet vezu.");
  }

  static Future<Person> slowCreateAccountWithName() async {
    await Future.delayed(const Duration(seconds: 10));
    return Person.createErrorPerson("Ne mogu da napravim novi nalog. Proveri internet konekciju.");
  }

  static Future<Person> longCreateUserWithEmailAndPassword() async {
    await Future.delayed(const Duration(seconds: 10));
    return Person.createErrorPerson("Ne mogu da kreiram novog korisnika. Proveri internet vezu.");
  }

  static Future<Person> longSignInWithEmailAndPassword() async {
    await Future.delayed(const Duration(seconds: 10));
    return Person.createErrorPerson("Ne mogu da ulogujem korisnika. Proveri internet vezu.");
  }

  static Future<bool> setBoolAfterWait(bool toSet, int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    return toSet;
  }

  static Future<bool> longUpdatePersonToDatabase() async {
    await Future.delayed(const Duration(seconds: 10));
    return false;
  }
}
