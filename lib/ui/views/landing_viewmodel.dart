import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/auth_service.dart';

class LandingViewModel extends StreamViewModel<User> {
  final _auth = locator<AuthService>();

  User get user => data;

  Stream<User> onAuthStateChanged() {
    return _auth.onAuthStateChanged;
  }

  @override
  Stream<User> get stream => onAuthStateChanged();
}
