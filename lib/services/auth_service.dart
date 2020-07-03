import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

class User {
  User(
      {@required this.displayName,
      @required this.photoUrl,
      @required this.uid});
  final String uid;
  final String displayName;
  final String photoUrl;

  @override
  String toString() {
    return '$uid , $displayName, $photoUrl';
  }
}

@lazySingleton
class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid,
        displayName: user.displayName,
        photoUrl: user.photoUrl ?? '');
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged
        .map((firebaseUser) => _userFromFirebase(firebaseUser));
  }

  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> signInWithEmailAndPassword(
      {@required email, @required password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> createWithEmailAndPassword(
      {@required email, @required password}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  // @override
  // Future<User> signInWithFacebook() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logIn(['public_profile']);

  //   if (result != null) {
  //     final authResult = await _firebaseAuth.signInWithCredential(
  //       FacebookAuthProvider.getCredential(
  //           accessToken: result.accessToken.token),
  //     );
  //     return _userFromFirebase(authResult.user);
  //   }
  //   return null;
  // }

  Future<void> signOut() async {
    // final facebookLogin = FacebookLogin();
    // await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
