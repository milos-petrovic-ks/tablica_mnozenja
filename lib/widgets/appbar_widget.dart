import 'package:flutter/material.dart';
import '../models/person.dart';
import '../utils/globals.dart';
import '../utils/constants.dart';
import '../services/auth.dart';
import '../screens/settings_screen.dart';
import '../screens/sign_in_register_screen.dart';
import '../screens/tab_navigation_screen.dart';
import '../screens/help_screen.dart';

class AppBarCommon extends StatelessWidget with PreferredSizeWidget {
  final String text;
  final bool isLogOutButton;
  final bool hasTabs;
  final bool isLevel2;
  AppBarCommon({
    required this.text,
    required this.isLogOutButton,
    required this.hasTabs,
    required this.isLevel2,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(hasTabs ? 120 : 90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: hasTabs ? 120 : 100,
      bottom: hasTabs ? tabBar() : null,
      title: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 40, top: 20),
          child: Text(
            text,
            style: const TextStyle(fontSize: 26),
          ),
        ),
      ),
      backgroundColor: COLOR_GREEN,
      elevation: 0.0,
      leading: isLogOutButton
          ? Container(
              margin: const EdgeInsets.only(top: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 26,
                ),
                onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInRegister(),
                    ),
                  );
                  if (!Person.isGuestPerson(Globals.loggedPerson)) {
                    await Authentication().signOut();
                  }
                },
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                ),
                onPressed: () {
                  Globals.showPracticeScreen = false;
                  if (isLevel2) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabNavigationScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
      actions: <Widget>[
        _appBarIcon(
          ctx: context,
          icon: Icons.settings,
          destination: const Settings(),
        ),
        _appBarIcon(
          ctx: context,
          icon: Icons.help_outline_sharp,
          destination: const HelpScreen(),
        )
      ],
    );
  }

  Container _appBarIcon({required ctx, required icon, required destination}) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: IconButton(
        icon: Icon(
          icon,
          size: 26,
        ),
        onPressed: () {
          Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (context) => destination,
            ),
          );
        },
      ),
    );
  }

  TabBar tabBar() {
    return TabBar(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 6.0, color: Colors.blue),
        insets: EdgeInsets.symmetric(horizontal: 5.0),
      ),
      tabs: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.check),
              Text(
                "Broj tačnih",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.speed),
              Text(
                "Niz bez greške",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
