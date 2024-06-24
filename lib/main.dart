import 'package:flutter/material.dart';

import 'package:mystroke_app/page/login_face.dart';

void main() {
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
      home: const LoginFace(),
    );
  }
}