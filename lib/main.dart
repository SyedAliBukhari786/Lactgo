import 'package:firebase_core/firebase_core.dart';
import 'package:lactgo/addproducts.dart';
import 'package:lactgo/bottombar.dart';
import 'package:lactgo/splashscreen.dart';
import 'package:lactgo/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser);

    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = BottomNavBar();
    } else {
      firstWidget = SplashScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: firstWidget,
    );
  }


}
