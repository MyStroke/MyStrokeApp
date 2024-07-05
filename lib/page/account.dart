import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatelessWidget {
  final User user;
  const Account({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt"
      ),
      home: const AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  // Get current user
  User get user => FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), 
            fit: BoxFit.cover,
          ),
        ),

        // Set child
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Text test with user email
              Text("Welcome, ${user.email}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Button sign out
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text("Sign out"),
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}