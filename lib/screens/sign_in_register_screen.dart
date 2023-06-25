import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../utils/long_operations.dart';
import '../widgets/users_list.dart';
import '../utils/constants.dart';
import '../widgets/widget_functions.dart';
import '../widgets/alert_dialogs.dart';

class SignInRegister extends StatefulWidget {
  const SignInRegister({Key? key}) : super(key: key);

  @override
  State<SignInRegister> createState() => _SignInRegisterState();
}

class _SignInRegisterState extends State<SignInRegister> {
  String nameFromInputBox = "";
  bool isCreatingNewPerson = false;
  @override
  Widget build(BuildContext context) {
    final formSignInKey = GlobalKey<FormState>();
    return StreamProvider<List<Person>>.value(
      initialData: const [],
      value: DatabaseService().personList,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          automaticallyImplyLeading: false,
          title: const Text(
            "Tablica množenja",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: COLOR_GREEN,
          elevation: 0.0,
        ),
        backgroundColor: COLOR_GREEN,
        body: isCreatingNewPerson
            ? const Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 50.0,
                ),
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  children: [
                    Form(
                      key: formSignInKey,
                      child: Column(
                        children: [
                          Text(
                            "Napravi novog korisnika",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          addVerticalSpace(15),
                          TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            initialValue: nameFromInputBox,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: _inputUserDecoration(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            validator: (val) =>
                                val!.length < 2 ? 'Unesi ime duže od 2 slova' : null,
                            onChanged: (val) => nameFromInputBox = val,
                          ),
                          addVerticalSpace(20),
                          ElevatedButton(
                            style: pinkElevatedButton(),
                            onPressed: () async {
                              if (formSignInKey.currentState!.validate()) {
                                setState(() => isCreatingNewPerson = true);
                                Person person = await Future.any([
                                  Authentication().createAccountWithName(nameFromInputBox),
                                  LongOpertions.slowCreateAccountWithName()
                                ]);
                                if (!mounted) return;

                                if (person.isErrorPerson()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return errorMessageDialog(context, person.error);
                                      });
                                }
                                setState(() => isCreatingNewPerson = false);
                              }
                            },
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    ),
                    addVerticalSpace(30),
                    Text(
                      "Izaberi korisnika",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    addVerticalSpace(10),
                    const UsersList(),
                  ],
                ),
              ),
      ),
    );
  }

  InputDecoration _inputUserDecoration() {
    return InputDecoration(
      labelText: "ime novog korisnika",
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.green[50],
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2.0),
      ),
    );
  }
}
