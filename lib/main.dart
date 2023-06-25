import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'services/device_id.dart';
import 'utils/constants.dart';
import 'screens/wrapper_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DeviceId.setDeviceId();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: COLOR_GREEN,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top],
    );
    return StreamProvider<String>.value(
      value: Authentication().userIdStream,
      initialData: "",
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tablica Mnozenja',
          theme: ThemeData(textTheme: customTextTheme),
          home: const Wrapper(
            loggedInAsGuest: false,
          )),
    );
  }
}
