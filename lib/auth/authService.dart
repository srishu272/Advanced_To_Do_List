import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credentials.user;
    } catch (e) {
      print("Something Went Wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credentials.user;
    } catch (e) {
      print("Something Went Wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      _auth.signOut();
    } catch (e) {
      print("Something Went Wrong");
    }
  }
}
