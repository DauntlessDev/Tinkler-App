import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/database_service.dart';
import 'package:tinkler/services/user_service.dart';
import 'package:tinkler/theme/app_theme_service.dart';

class ProfileViewModel extends StreamViewModel<Profile> {
  final _auth = locator<AuthenticationService>();
  final _database = locator<DatabaseService>();
  final _user = locator<UserService>();
  final _dialog = locator<DialogService>();
  final _theme = locator<AppThemeService>();

  Profile get profile {
    if (data == null) {
      return Profile(photoUrl: '', displayName: '', email: '');
    } else {
      return Profile(
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

      await _database.addProfile(profile.copyWith(photoUrl: downloadUrl));
      notifyListeners();
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Profile', description: e.message);
    } catch (e) {}
    setBusy(false);
  }

  Future<void> signOut() async {
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

  Stream<Profile> profileStream() => _database.profileStream();

  @override
  Stream<Profile> get stream => profileStream();
}
