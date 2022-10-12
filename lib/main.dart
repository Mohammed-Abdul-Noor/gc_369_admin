import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ADMIN MODULE/navigation/navigationProvider.dart';
import 'ADMIN MODULE/routing/loginpage.dart';

int test = 0;

void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDWb-suA6XgexU63HIZtUphjSmg3b5j-l0",
            authDomain: "global-club-d7980.firebaseapp.com",
            projectId: "global-club-d7980",
            storageBucket: "global-club-d7980.appspot.com",
            messagingSenderId: "448070656445",
            appId: "1:448070656445:web:3d9580465f52ee978fb2d4",
            measurementId: "G-HMXFK08BSB"));
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    runApp(const MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: ((context) => NavigationProvider()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Loginpage(),
        ),
      );
}
