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
      return Profile(
          photoUrl: '', displayName: '', email: '', isDarkMode: false);
    } else {
      return Profile(
          photoUrl: data.displayName,
          displayName: data.displayName ?? '',
          email: data.email ?? '',
          isDarkMode: data.isDarkMode);
    }
  }

  void toggleDarkMode(bool value) {
    _theme.updateTheme(value);
    notifyListeners();
  }

  Stream<Profile> profileStream() => _database.profileStream();

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
  Stream<Profile> get stream => profileStream();
}
