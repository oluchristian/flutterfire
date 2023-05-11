import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //register user
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User created: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }
}
