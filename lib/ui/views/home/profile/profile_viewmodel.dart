import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
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
  Future<User> futureToRun() => currentUser();
}
