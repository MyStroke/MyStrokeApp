import 'package:firebase_auth/firebase_auth.dart';

import './auth_exception.dart';

class AuthService {
  late AuthResultStatus status;

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
}