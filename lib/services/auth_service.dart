import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //register user
  Future<User?> register(String email, BuildContext context, String password) async {

    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red,),);
    } catch (e) {
      print(e);
    }


  }
  //login

  Future<User?> login(String email, BuildContext context, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);
    }

  }

  //Google Sign in
  Future<User?> signInWithGoogle() async {
try {
      //Trigger the authentication dialog
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      //obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      //create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      //once signed in return the user data from firebase
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    }
} catch (e) {
  print(e);
}
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
