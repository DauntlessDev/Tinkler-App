import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/database_service.dart';
import 'package:tinkler/services/user_service.dart';
import 'package:tinkler/theme/app_theme_service.dart';

class ProfileViewModel extends FutureViewModel<User> {
  final _auth = locator<AuthenticationService>();
  final _database = locator<DatabaseService>();
  final _user = locator<UserService>();
  final _dialog = locator<DialogService>();
  final _theme = locator<AppThemeService>();

  User get profile {
    print(data.toString());
    if (data == null) {
      return User(photoUrl: '', displayName: '', email: '');
    } else {
      return User(
          photoUrl: data.photoUrl ?? '',
          displayName: data.displayName,
          email: data.email);
    }
  }

  void toggleDarkMode(bool value) {
    _theme.updateTheme(value);
    notifyListeners();
  }

  Future<void> changeProfile() async {
    setBusy(true);
    try {
      File _image = await _database.getImage();
      String downloadUrl = await _database.uploadProfilePic(image: _image);

      print('upload complete');
      await _auth.updateProfile(downloadUrl);
      print('update profile complete, $downloadUrl');

      await initialise();

      print('reruncomplete');
      notifyListeners();
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Profile', description: e.message);
    } catch (e) {}
    setBusy(false);
  }

  Future<void> signOut() async {
    print('profile stream: ${profile.toString()}');
    try {
      DialogResponse decision = await _dialog.showConfirmationDialog(
        title: 'Log-out',
        description: 'Are you sure in logging out?',
        confirmationTitle: 'Confirm',
        cancelTitle: 'Cancel',
      );

      if (decision.confirmed) {
        await _auth.signOut();
        _user.updateUserUid('');
      }
    } on PlatformException catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }

  @override
  Future<User> futureToRun() {
    print('run future to run');
    return _auth.currentUser();
  }
}
