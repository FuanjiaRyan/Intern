import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user, then save their name in Firestore
  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;

      if (user != null) {
        try {
          await user.updateDisplayName(username);
        } catch (_) {}

        // If Firestore is not ready, still return the user so Home can open
        try {
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': email,
            'username': username,
          });
        } catch (_) {}
      }

      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // Login
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await saveCurrentUserToFirestore();

      return credential.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // If an older account is missing from Firestore, add it now
  Future<void> saveCurrentUserToFirestore() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email ?? '',
          'username': user.displayName ?? user.email ?? 'User',
        });
      }
    } catch (_) {}
  }
}
