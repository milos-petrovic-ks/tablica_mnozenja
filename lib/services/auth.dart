import 'package:firebase_auth/firebase_auth.dart';
import '../utils/common.dart';
import '../utils/globals.dart';
import '../models/person.dart';
import '../services/database.dart';
import '../utils/constants.dart';
import '../utils/long_operations.dart';
import 'device_id.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String> get userIdStream {
    var users = _auth.authStateChanges().map((User? user) => user == null ? "" : user.uid);
    return users;
  }

  Future<Person> createAccountWithName(String name) async {
    try {
      String domainName = DeviceId.getDomainName();
      if (name.contains(" ")) {
        return Person.createErrorPerson("U imenu ne treba da postoje razmaci.");
      }
      if (name.toLowerCase() == GUEST_NAME.toLowerCase()) {
        return Person.createErrorPerson("Korisnik ne može da ima ime $GUEST_NAME.");
      }
      String email = "$name@$domainName.com";
      String password = "12345678";

      DatabaseService dbService = DatabaseService();
      dynamic result = await Future.any(
        [
          _auth.createUserWithEmailAndPassword(email: email, password: password),
          LongOpertions.longCreateUserWithEmailAndPassword()
        ],
      );
      // OVO JE AKO SE AKTIVIRAO longCreateUserWithEmailAndPassword
      if (result is Person) {
        return result;
      }

      User? user = result.user;
      if (user != null) {
        Person p = Person(user.uid, name, email);
        await dbService.addPersonToDatabase(p);
        return p;
      }

      return Person.createErrorPerson("Dogodila se nepoznata greška prilikom kreiranja korisnika.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Person.createErrorPerson("Korisnik sa imenom $name je već registrovan.");
      }
      return Person.createErrorPerson("Dogodila se nepoznata greška prilikom kreiranja korisnika.");
    }
  }

  Future<Person> signInWithName(String name) async {
    try {
      String domainName = DeviceId.getDomainName();
      String email = "$name@$domainName.com";
      String password = "12345678";
      dynamic result = await Future.any([
        _auth.signInWithEmailAndPassword(email: email, password: password),
        LongOpertions.longSignInWithEmailAndPassword()
      ]);

      if (result is Person) {
        return result;
      }

      User? user = result.user;
      if (user != null) {
        Person p = Person(user.uid, name, email);
        return p;
      }
      return Person.createErrorPerson("Došlo je do greške prilikom logovanja korisnika.");
    } catch (e) {
      return Person.createErrorPerson("Došlo je do greške prilikom logovanja korisnika.");
    }
  }

  Future<void> signOut() async {
    try {
      await DatabaseService().updatePersonToDatabase(Globals.loggedPerson);
      Globals.loggedPerson = Person.createEmptyPerson();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Common.toConsole(e.toString(), title: "SIGN OUT ERROR");
    }
  }

  Future deleteCurrentUser() async {
    String personId = FirebaseAuth.instance.currentUser?.uid ?? "";
    await DatabaseService().deletePersonByPersonUID(personId);
    await FirebaseAuth.instance.currentUser!.delete();
    await Authentication().signOut();
  }
}
