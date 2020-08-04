import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/model/user.dart';

import 'database_service.dart';

@lazySingleton
class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
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

  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_User']);

    if (result != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token),
      );

      final _database = locator<DatabaseService>();
      _database.profileFuture(email: authResult.user.email).then((value) async {
        setSearchParam(String caseNumber) {
          List<String> caseSearchList = List();
          String temp = "";
          for (int i = 0; i < caseNumber.length; i++) {
            temp = temp + caseNumber[i];
            caseSearchList.add(temp);
          }
          return caseSearchList;
        }

        if (value == null) {
          await _database.setProfile(Profile(
            uid: authResult.user.uid,
            displayName: authResult.user.displayName,
            email: authResult.user.email,
            photoUrl: authResult.user.photoUrl,
            caseSearch:
                setSearchParam(authResult.user.displayName.toLowerCase()),
            followers: 0,
            following: 0,
            posts: 0,
          ));
        }
      });

      return _userFromFirebase(authResult.user);
    }
    return null;
  }

  Future<void> signOut() async {
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
