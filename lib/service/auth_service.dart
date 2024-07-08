import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import './auth_exception.dart';

class AuthService {
  late AuthResultStatus status;

  // Login with email and password
  Future<AuthResultStatus> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (authResult.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
      return status;
    } catch (msg) {
      status = AuthExceptionHandler.handleException(msg);
    }
    return status;
  }

  // Register with email and password
  Future<AuthResultStatus> registerWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (authResult.user != null) {
        _saveUserData(
          username: username, 
          email: email, 
          userId: authResult.user!.uid
        );
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
      return status;
    } catch (msg) {
      status = AuthExceptionHandler.handleException(msg);
    }
    return status;
  }

  void _saveUserData({required String username, email, userId}) {
    FirebaseFirestore.instance.collection("Patient").doc(userId).set({
      'username': username,
      'email': email,
      'information': {
        'prefix': '',
        'first_name': '',
        'last_name': '',
        'age': 0,
        'gender': '',
        'profile': 'https://firebasestorage.googleapis.com/v0/b/mystroke-c4378.appspot.com/o/UnknowUser.png?alt=media&token=56b96cc6-9c5c-4756-a97b-f676e95a9482',
        'additional_diseases': '',
      },
      'class_id': '',
    });
  }

  // Face login
  Future<void> uploadFaceData(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();

    try {
      final createEmailandPassword = DateTime.now().millisecondsSinceEpoch;
      final UserCredential authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "$createEmailandPassword@gmail.com", 
        password: createEmailandPassword.toString()
      );

      if (authResult.user == null) {
        throw Exception('User not found');
      }

      final userId = authResult.user!.uid;
      
      // Save face data to Firestore
      await FirebaseFirestore.instance.collection("Patient").doc(userId).set({
        'username': userId,
        'email': "$createEmailandPassword@gmail.com",
        'information': {
          'prefix': '',
          'first_name': '',
          'last_name': '',
          'age': 0,
          'gender': '',
          'profile': 'https://firebasestorage.googleapis.com/v0/b/mystroke-c4378.appspot.com/o/UnknowUser.png?alt=media&token=56b96cc6-9c5c-4756-a97b-f676e95a9482',
          'additional_diseases': '',
        },
        'class_id': '',
      });

      // Save face data to Firebase Storage
      await FirebaseStorage.instance.ref('faces/$userId.jpg').putData(bytes);

      debugPrint("image bytes : $bytes");
      debugPrint('Face data uploaded successfully');
    } catch (e) {
      debugPrint('Error uploading face data: $e');
    }
  }
}