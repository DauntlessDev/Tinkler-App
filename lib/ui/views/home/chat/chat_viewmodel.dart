import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/auth_service.dart';

class ChatViewModel extends FutureViewModel {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();

  User _user;
  User get user => _user;
  String get userPhotoUrl {
    try {
      return _user.photoUrl;
    } catch (e) {
      return '';
    }
  }

  Future<void> currentUser() async {
    _user = await _auth.currentUser();
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
  Future<void> futureToRun() => currentUser();
}
