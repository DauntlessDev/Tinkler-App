import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  TabItem _currentTab = TabItem.chat;
  TabItem get currentTab => _currentTab;

  void select(TabItem value, navigatorKeyValue) {
    if (value == _currentTab) {
      // navigatorKeyValue.currentState.popUntil((route) => route.isFirst);
    } else {
      _currentTab = value;
      notifyListeners();
    }
  }
}

enum TabItem { posts, chat, profile }
