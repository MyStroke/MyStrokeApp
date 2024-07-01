import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

class AuthGetdata {
  // Get user data
  Future<Map<String, dynamic>> getUserData() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final userDoc = FirebaseFirestore.instance.collection("Patient").doc(user.uid).snapshots();
    final userData = await userDoc.first;
    return userData.data() as Map<String, dynamic>;
  }
}