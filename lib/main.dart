import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';

import 'package:mystroke_app/service/auth_check.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyStroke',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt"
      ),
      home: const AuthCheck(),
    );
  }
}