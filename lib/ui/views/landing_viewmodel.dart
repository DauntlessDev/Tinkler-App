import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/user_service.dart';

class LandingViewModel extends BaseViewModel {
  final _auth = locator<AuthenticationService>();
  final _navigation = locator<NavigationService>();
  final _user = locator<UserService>();

  void subscribeToAuthStateChanged() {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        _user.updateUserUid(user.uid);
        _navigation.navigateTo(Routes.homeViewRoute);
      } else {
        _user.updateUserUid('');
        _navigation.navigateTo(Routes.loginViewRoute);
      }
    });
  }
}
