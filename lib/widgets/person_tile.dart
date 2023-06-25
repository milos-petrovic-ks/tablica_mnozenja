import "package:flutter/material.dart";
import 'package:tablica_mnozenja/utils/common.dart';
import '../models/person.dart';
import '../screens/wrapper_screen.dart';
import '../services/auth.dart';
import '../utils/constants.dart';
import '../utils/long_operations.dart';

class PersonTile extends StatefulWidget {
  final Person person;

  const PersonTile(this.person, {super.key});

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> {
  bool isSignInProgress = false;
  bool canSignInWithName = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
        child: ListTile(
          onTap: () async {
            if (Person.isGuestPerson(widget.person)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(
                    loggedInAsGuest: true,
                  ),
                ),
              );
              return;
            }
            setState(() => isSignInProgress = true);
            Person loggedInPerson = await Authentication().signInWithName(widget.person.name);

            if (loggedInPerson.isErrorPerson()) {
              setState(
                () {
                  isSignInProgress = false;
                  canSignInWithName = false;
                },
              );
              canSignInWithName = await LongOpertions.setBoolAfterWait(true, 3);
              setState(
                () {
                  canSignInWithName = true;
                },
              );
            }
            isSignInProgress = await LongOpertions.setBoolAfterWait(true, 2);
            // ignore: use_build_context_synchronously
            try {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(
                    loggedInAsGuest: false,
                  ),
                ),
              );
            } catch (e) {
              Common.toConsole(e.toString(), title: "PERSON TILE");
            }

            if (mounted) {
              setState(() => isSignInProgress = false);
            }
          },
          title: Text(
            _getTileText(),
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: Person.isGuestPerson(widget.person)
              ? const Icon(Icons.person_outline)
              : const Icon(
                  Icons.person,
                  size: 26,
                  color: Color.fromARGB(255, 70, 157, 227),
                ),
          tileColor: _getTileColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
            side: _getBorderSide(),
          ),
        ),
      ),
    );
  }

  BorderSide _getBorderSide() {
    if (Person.isGuestPerson(widget.person)) {
      return BorderSide(width: 2, color: Colors.yellowAccent[300] ?? Colors.yellowAccent);
    }
    if (isSignInProgress) {
      return BorderSide(width: 2, color: Colors.orange[700] ?? Colors.black);
    }
    return BorderSide(width: 2, color: Colors.blue[100] ?? Colors.black);
  }

  String _getTileText() {
    if (Person.isGuestPerson(widget.person)) {
      return "$GUEST_NAME (radi bez interneta)";
    }
    if (isSignInProgress) {
      return "Učitavanje...";
    }
    if (!canSignInWithName) {
      return "Ne mogu da se ulogujem. Proveri internet konekciju.";
    }
    return widget.person.name;
  }

  Color _getTileColor() {
    if (Person.isGuestPerson(widget.person)) {
      return Colors.yellowAccent[100] ?? Colors.yellowAccent;
    }
    if (isSignInProgress) {
      return Colors.orange;
    }
    if (!canSignInWithName) {
      return Colors.red[200] ?? Colors.red;
    }
    return Colors.blue[50] ?? Colors.blue;
  }
}
