import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_shopping_app/model/user_model.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Status _status = Status.Uninitialized;

  Status get status => _status;

  // Stream for auth state changes, converting Firebase User to your UserModel
  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  // Create a UserModel from Firebase User
  UserModel _userFromFirebase(User? user) {
    if (user == null) {
      return UserModel(displayName: 'Null', uid: 'null');
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
    );
  }

  // Handle auth state changes
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      print('User is unauthenticated.');
    } else {
      _status = Status.Authenticated;
      print('User is authenticated with UID: ${firebaseUser.uid}');
    }
    notifyListeners();
  }

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> singup(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print("Sing up failed:$e");
      }
      return null;
    }
  }

  // Sign in with email and password
  // Future<UserCredential?> signInWithEmailAndPassword(
  // String email, String password) async {
  // try {
  //_status = Status.Authenticating;
  //notifyListeners();
  //final UserCredential result = await _auth.signInWithEmailAndPassword(
  //  email: email, password: password);
  // print("Sign-in successful for user: ${result.user?.email}");
  // return result; // Return the UserCredential
  // } catch (e) {
  // Check the type of error
  //  if (e is FirebaseAuthException) {
  //   switch (e.code) {
  //    case 'user-not-found':
  //    print("No user found for that email.");
  //  break;
  // case 'wrong-password':
  //  print("Wrong password provided for that user.");
  //  break;
  // case 'invalid-email':
  //  print("The email address is not valid.");
  //  break;
  // default:
  //    print("Error during sign-in: $e");
  // }
  //  }
  // _status = Status.Unauthenticated;
  // notifyListeners();
  //  return null; // Return null on error
  //  }
  // }
  Future<User?> signin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Handle Firebase Authentication specific errors
        switch (e.code) {
          case 'invalid-email':
            print('The email address is badly formatted.');
            break;
          case 'user-not-found':
            print('No user found for that email.');
            break;
          case 'wrong-password':
            print('Wrong password provided for that user.');
            break;
          default:
            print('Firebase Auth error: ${e.message}');
        }
      } else {
        print('An unknown error occurred: $e');
      }
      return null;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent to: $email");
    } catch (e) {
      print("Error in sending password reset email: $e");
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _status = Status.Unauthenticated;
      notifyListeners();
      print('User signed out.');
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
}
