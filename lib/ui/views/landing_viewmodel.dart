import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';
import 'package:tinkler/services/functional_services/push_notification_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class LandingViewModel extends StreamViewModel<User> {
  final _auth = locator<AuthenticationService>();
  final _user = locator<CurrentUserService>();
  final _visitProfile = locator<VisitProfileService>();
  final _pushNotificationService = locator<PushNotificationService>();

  User get user => data;
  Stream<User> onAuthStateChanged() {
    _pushNotificationService.initialise();
    _auth.onAuthStateChanged.listen((event) async {
      try {
        if (event != null) {
          _user.updateCurrentUserInfo(event);
          _visitProfile.checkUserFollowing();
        }
      } on PlatformException catch (e) {
        print('landing page updating user field: ${e.message}');
      }
    });
    return _auth.onAuthStateChanged;
  }

  @override
  Stream<User> get stream => onAuthStateChanged();
}
