import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore/models/user.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult resoult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = resoult.user;
      return User.formFirebase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> registerInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult resoult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = resoult.user;
      return User.formFirebase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get currentUser {
    return _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user != null ? User.formFirebase(user) : null);
  }
}
