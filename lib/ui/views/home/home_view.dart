//view class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/home/posts/posts_view.dart';
import 'package:tinkler/ui/views/home/profile/profile_view.dart';

import 'chat/chat_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: _CupertinoHomeScaffold(
            currentTab: model.currentTab,
            onSelectTab: model.select,
            widgetBuilders: widgetBuilders,
            navigatorKey: navigatorKey),
      ),
    );
  }
}

class _CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final Function onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey;

  _CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      @required this.widgetBuilders,
      @required this.navigatorKey,
      CupertinoTabBar builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        items: [
          _buildItem(TabItem.posts),
          _buildItem(TabItem.chat),
          _buildItem(TabItem.profile),
        ],
        onTap: (index) =>
            onSelectTab(TabItem.values[index], navigatorKey[index]),
      ),
      tabBuilder: (BuildContext context, int index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKey[item],
          builder: (context) => widgetBuilders[item](context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = _TabItemData.allData[tabItem];
    final color = currentTab == tabItem ? Colors.blue[900] : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
    );
  }
}

class _TabItemData {
  const _TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, _TabItemData> allData = {
    TabItem.posts: _TabItemData(
      title: 'Home',
      icon: MdiIcons.homeOutline,
    ),
    TabItem.chat: _TabItemData(title: 'Chat', icon: MdiIcons.chatOutline),
    TabItem.profile: _TabItemData(
      title: 'Profile',
      icon: MdiIcons.accountOutline,
    ),
  };
}
