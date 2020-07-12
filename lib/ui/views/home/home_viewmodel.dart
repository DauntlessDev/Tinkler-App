import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _user = locator<UserService>();
  final _auth = locator<AuthenticationService>();
  Future<void> initialize() async {
    User user = await _auth.currentUser();
    _user.updateCurrentUserInfo(user);
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
