import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/home/posts/posts_view.dart';
import 'chat/chat_view.dart';
import 'profile/profile_view.dart';

class HomeViewModel extends BaseViewModel {
  TabItem _currentTab = TabItem.chat;
  TabItem get currentTab => _currentTab;

  void select(TabItem value) {
    if (value == _currentTab) {
      navigatorKey[value].currentState.popUntil((route) => route.isFirst);
    } else {
      _currentTab = value;
      notifyListeners();
    }
  }

  Map<TabItem, GlobalKey<NavigatorState>> get navigatorKey {
    return {
      TabItem.posts: PostsView.navigatorKey,
      TabItem.chat: ChatView.navigatorKey,
      TabItem.profile: ProfileView.navigatorKey,
    };
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.posts: (_) => PostsView(),
      TabItem.chat: (_) => ChatView(),
      TabItem.profile: (_) => ProfileView(),
    };
  }
}

enum TabItem { posts, chat, profile }
