import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class AuthBase {
  User? get currentUser;

  Future<User?> register(String email, String password);

  Future<User?> login(String email, String password);

  Future<void> logout();
}

@LazySingleton(as: AuthBase)
class AuthService implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userAuth.user;
    } on GenericApplicationException catch (error) {
      debugPrint(error.message);
      return null;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userAuth.user;
    } on GenericApplicationException catch (error) {
      debugPrint(error.message);
      return null;
    }
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();
}
