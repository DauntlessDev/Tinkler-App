import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import 'chat/chat_view.dart';
import 'people/people_view.dart';
import 'random/random_view.dart';

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
      TabItem.chat: ChatView.navigatorKey,
      TabItem.random: RandomView.navigatorKey,
      TabItem.people: PeopleView.navigatorKey,
    };
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.chat: (_) => ChatView(),
      TabItem.random: (_) => RandomView(),
      TabItem.people: (context) => PeopleView(),
    };
  }
}

enum TabItem { chat, random, people }
