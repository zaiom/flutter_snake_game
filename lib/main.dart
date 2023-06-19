import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBeLZmUQBknKOchu7JvpCiqpjO2I_oeR_c",
      authDomain: "snakegame-1e59d.firebaseapp.com",
      projectId: "snakegame-1e59d",
      storageBucket: "snakegame-1e59d.appspot.com",
      messagingSenderId: "961402704841",
      appId: "1:961402704841:web:da50065e371d993d948e18",
      measurementId: "G-EVLKPCXYPE"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}