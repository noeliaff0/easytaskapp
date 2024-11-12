import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  AuthProvider() {
    _user = _firebaseAuth.currentUser;
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  // Método para iniciar sesión
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Error en inicio de sesión: ${e.toString()}");
    }
  }

  // Método para registrar usuario
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Error en registro: ${e.toString()}");
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }
}
