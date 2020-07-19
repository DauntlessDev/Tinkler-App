import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  TabItem _currentTab = TabItem.posts;
  TabItem get currentTab => _currentTab;

  void select(TabItem value, navigatorKeyValue) {
    if (value != _currentTab) {
      _currentTab = value;
      notifyListeners();
    }
  }
}

enum TabItem { posts, search, chat, profile }
