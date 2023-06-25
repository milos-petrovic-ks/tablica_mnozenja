import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../utils/constants.dart';
import '../models/person.dart';
import 'person_tile.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    List<Person> persons = List.from(Provider.of<List<Person>>(context));
    bool containsGuest = false;
    for (var i = 0; i < persons.length; i++) {
      if (persons[i].name == GUEST_NAME) {
        containsGuest = true;
      }
    }

    if (!containsGuest) {
      persons.add(Person.createGuestPerson());
    }

    return Expanded(
      child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (BuildContext context, int index) {
          return PersonTile(persons[index]);
        },
      ),
    );
  }
}
