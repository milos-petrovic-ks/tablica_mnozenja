import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/globals.dart';
import '../models/person.dart';
import '../screens/sign_in_register_screen.dart';
import '../services/database.dart';
import 'tab_navigation_screen.dart';

class Wrapper extends StatelessWidget {
  final bool loggedInAsGuest;
  const Wrapper({required this.loggedInAsGuest, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<String>(context);
    return FutureBuilder<Person?>(
      future: DatabaseService().getPersonByPersonUID(userId),
      builder: (context, AsyncSnapshot<Person?> snapshot) {
        if (loggedInAsGuest) {
          Person currentUser = Person.createGuestPerson();
          Globals.loggedPerson = currentUser;
          return TabNavigationScreen();
        }
        if (snapshot.data == null) {
          Globals.loggedPerson = Person.createEmptyPerson();
          return const SignInRegister();
        } else {
          Person currentUser = snapshot.data ?? Person.createGuestPerson();
          Globals.loggedPerson = currentUser;
          return TabNavigationScreen();
        }
      },
    );
  }
}
