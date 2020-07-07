import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _user = locator<UserService>();
  final _auth = locator<AuthenticationService>();
  void initialize() {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        _user.updateUserUid(user.uid);
      } else {
        _user.updateUserUid('');
      }
      notifyListeners();
    });
  }

  TabItem _currentTab = TabItem.chat;
  TabItem get currentTab => _currentTab;

  void select(TabItem value, navigatorKeyValue) {
    if (value == _currentTab) {
      navigatorKeyValue.currentState.popUntil((route) => route.isFirst);
    } else {
      _currentTab = value;
      notifyListeners();
    }
  }
}

enum TabItem { posts, chat, profile }
