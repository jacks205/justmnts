import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthStore extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instanceFor(app: Firebase.app());
  User user;
  bool hasCurrentUser;
  bool hasSignedIn = false;

  AuthStore() {
    hasCurrentUser = _firebaseAuth.currentUser != null;
    _firebaseAuth.authStateChanges().listen((user) {
      this.user = user;
      notifyListeners();
    });
  }
  void anonSignIn() async {
    if (user == null && !hasSignedIn) {
      hasSignedIn = true;
      await _firebaseAuth.signInAnonymously();
    }
  }
}
