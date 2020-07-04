import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/auth_service.dart';

class ProfileViewModel extends FutureViewModel {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();

  User get user => data;
  String get userPhotoUrl => user != null ? user.photoUrl : '';

  Future<User> currentUser() async {
    return await _auth.currentUser();
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }

  @override
  Future<User> futureToRun() => currentUser();
}


class Option {
  final String title;
  final Icon icon;
  final String subTitle;
  final String category;
  final Function onTap;

  Option(
      {@required this.title,
      @required this.icon,
      this.subTitle,
      this.category,
      @required this.onTap});
}
