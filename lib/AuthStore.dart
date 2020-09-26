import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthStore extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instanceFor(app: Firebase.app());
  bool isLoggedIn = false;

  AuthStore() {
    isLoggedIn = _firebaseAuth.currentUser != null;
    print(isLoggedIn);
    _firebaseAuth.authStateChanges().listen((user) {
      print(user);
      isLoggedIn = user != null;
    });
  }
  void anonSignIn() async {
    _firebaseAuth.signInAnonymously();
  }
}
