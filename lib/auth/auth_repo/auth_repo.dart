import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';

class AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<AppUser?> getCurrentUser() async {
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      return null;
    }
    return AppUser(uid: currentUser.uid, email: currentUser.email!, name: '');
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  Future<AppUser?> loginWithEmailAndPassword(

      String email, String password) async {
    try {
      // Trying to SignIn
      UserCredential userCredential = await auth.signInWithEmailAndPassword(

          email: email, password: password);


      // Create User
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');

      return user;
    } on FirebaseException catch (e) {
      


      log('Failed with error code: ${e.code}');
      throw Exception('Login Failed: $e');
    }
    // return null;
  }

  Future<AppUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Trying to Sign Up
      print(email);
      print(password);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("UserCredential: $userCredential");

      // Create User
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // Save Data To Database
      await firestore.collection('users').doc(user.uid).set(user.toJson());

      return user;
    } catch (error) {
      throw Exception('SignUp Failed: $error');
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();



  // Sign In with Google
  Future<AppUser?> signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase using the Google authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await auth.signInWithCredential(credential);

      // Get the user details
      final User? user = userCredential.user;

      if (user != null) {
        // Map Firebase user to your custom AppUser model
        return AppUser(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',

        );
      }
      return null;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

}

