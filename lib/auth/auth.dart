import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/LoginScreen.dart';
import '../userCreate.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentuser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();



  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

    Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut(BuildContext context,UserDatabase userDatabase,Auth userAuth) async{
    await _firebaseAuth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(userDatabase,userAuth)),
    );
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getCurrentUserId() {
    final User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }
}
