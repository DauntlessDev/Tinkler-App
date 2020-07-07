import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/database_service.dart';
import 'package:tinkler/services/user_service.dart';

class ProfileViewModel extends StreamViewModel<Profile> {
  final _auth = locator<AuthenticationService>();
  final _database = locator<DatabaseService>();
  final _dialog = locator<DialogService>();
  final _user = locator<UserService>();

  Profile get profile => data;
  Stream<Profile> profileStream() {
    return _database.profileStream(uid: _user.uid);
  }

  Future<void> signOut() async {
    try {
      DialogResponse decision = await _dialog.showConfirmationDialog(
        title: 'Log-out',
        description: 'Are you sure in logging out?',
        confirmationTitle: 'Confirm',
        cancelTitle: 'Cancel',
      );

      if (decision.confirmed) await _auth.signOut();
    } catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }

  @override
  Stream<Profile> get stream => profileStream();
}
