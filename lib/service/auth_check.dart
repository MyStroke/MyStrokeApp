import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Page
import '../page/route_page.dart';
import '../page/login_face.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const RouterPage();
          } else if (snapshot.hasError) {
            return const Text("Error occurred!");
          } else {
            return const LoginFace();
          }
        },
      ),
    );
  }
}
