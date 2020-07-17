import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class LandingViewModel extends StreamViewModel<User> {
  final _auth = locator<AuthenticationService>();
  final _user = locator<CurrentUserService>();

  User get user => data;
  Stream<User> onAuthStateChanged() {
    _auth.onAuthStateChanged.listen((event) {
      try {
        if (event != null) {
          _user.updateCurrentUserInfo(event);
        }
      } on PlatformException catch (e) {
        print('landing page updating user faield: ${e.message}');
      }
    });
    return _auth.onAuthStateChanged;
  }

  @override
  Stream<User> get stream => onAuthStateChanged();
}
