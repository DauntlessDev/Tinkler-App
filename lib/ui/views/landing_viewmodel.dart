import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/user_service.dart';

class LandingViewModel extends StreamViewModel<User> {
  final _user = locator<UserService>();
  final _auth = locator<AuthenticationService>();

  // void initialize() {
  //   _auth.onAuthStateChanged.listen((user) {
  //     if (user != null) {
  //       _user.updateUserUid(user.uid);
  //     } else {
  //       _user.updateUserUid('');
  //     }
  //     notifyListeners();
  //   });
  // }

  User get user => data;
  Stream<User> onAuthStateChanged() {
    return _auth.onAuthStateChanged;
  }

  @override
  Stream<User> get stream => onAuthStateChanged();
}
