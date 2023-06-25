import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/common.dart';
import '../models/person.dart';
import 'device_id.dart';

class DatabaseService {
  DatabaseService();
  Stream<List<Person>> get personList {
    String deviceId = DeviceId.deviceId;
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where("deviceId", isEqualTo: deviceId)
          .snapshots()
          .map(
            (snapShot) => snapShot.docs
                .map(
                  (document) => Person.fromJson(
                    document.data(),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      return const Stream<List<Person>>.empty();
    }
  }

  Future<void> addPersonToDatabase(Person p) async {
    return FirebaseFirestore.instance
        .collection('users')
        .add({
          'uid': p.uid,
          'name': p.name,
          'email': p.email,
          'deviceId': DeviceId.deviceId,
          'numTries': p.attemptsToSting(),
          'numCorrect': p.numCorrectToSting(),
          'numbersToPractice': p.numbersToPracticeToString(),
          'strikes': p.strikesToString(),
          'maxStrikes': p.maxStrikesToString(),
          'sound': true,
          'showCorrectAnswer': true
        })
        .then((value) =>
            Common.toConsole("DatabaseService().addPersonToDatabaseUser(p) : ${p.uid} added"))
        .catchError((error) => Common.toConsole("Failed to add user: $error"));
  }

  Future<bool> updatePersonToDatabase(Person? p) async {
    bool rez = false;
    if (p == null) {
      // print("ERROR: DatabaseService().updatePersonToDatabase(p) : Person p je null");
      return rez;
    }
    if (Person.isGuestPerson(p)) {
      return true;
    }
    String docId = await DatabaseService().getDocumentIdByPersonUID(p.uid);
    if (docId == "") {
      // print("ERROR: DatabaseService().updatePersonToDatabase(p) : DocId je prazan");
      return rez;
    }
    await FirebaseFirestore.instance.collection("users").doc(docId).update({
      'uid': p.uid,
      'name': p.name,
      'email': p.email,
      'deviceId': p.deviceId,
      'numTries': p.attemptsToSting(),
      'numCorrect': p.numCorrectToSting(),
      'numbersToPractice': p.numbersToPracticeToString(),
      'strikes': p.strikesToString(),
      'maxStrikes': p.maxStrikesToString(),
      'sound': p.sound,
      'showCorrectAnswer': p.showCorrectAnswer,
    }).then((value) {
      // print("DatabaseService().updatePersonToDatabase(p) : ${p.uid} update");
      rez = true;
    }).catchError((error) {
      // print("ERROR: DatabaseService().updatePersonToDatabase(p) : Failed to update user: $error");
      rez = false;
    });
    return rez;
  }

  Future<Person?> getPersonByPersonUID(String personUID) async {
    if (personUID.isEmpty) {
      return null;
    }
    Person? personByUid;
    await FirebaseFirestore.instance.collection('users').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["uid"] == personUID) {
            personByUid = Person.all(
              doc["uid"],
              doc["name"],
              doc["email"],
              doc["numTries"],
              doc["numCorrect"],
              doc["numbersToPractice"],
              doc["strikes"],
              doc["maxStrikes"],
              doc["sound"],
              doc["showCorrectAnswer"],
            );
          }
        }
      },
    );
    return personByUid;
  }

  Future<String> getDocumentIdByPersonUID(String personUID) async {
    String documentId = "";
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["uid"] == personUID) {
          documentId = doc.reference.id;
        }
      }
    });
    return documentId;
  }

  Future<void> deletePersonByPersonUID(String personUID) async {
    String documentId = await getDocumentIdByPersonUID(personUID);
    if (documentId == "") {
      return;
    }
    await FirebaseFirestore.instance.collection('users').doc(documentId).delete();
  }

  Future<List<List<String>>> getAllPersonsUIDAndNames() async {
    List<List<String>> result = [];
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        result.add([doc["uid"], doc["name"]]);
      }
    });
    return result;
  }
}
