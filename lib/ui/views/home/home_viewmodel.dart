import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class HomeViewModel extends BaseViewModel {
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();

  TabItem _currentTab = TabItem.posts;
  TabItem get currentTab => _currentTab;

  void select(TabItem value, navigatorKeyValue) {
    if (value != _currentTab) {
      if (value == TabItem.profile)
        _visitProfile.addVisitProfileEmail(_user.email);
        
      _currentTab = value;
      notifyListeners();
    }
  }
}

enum TabItem { posts, search, chat, profile }
