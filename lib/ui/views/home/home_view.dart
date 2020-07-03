//view class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/constants.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CupertinoHomeScaffold(
            currentTab: model.currentTab,
            onSelectTab: model.select,
            widgetBuilders: model.widgetBuilders,
            navigatorKey: model.navigatorKey),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey;

  const CupertinoHomeScaffold(
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
        items: [
          _buildItem(TabItem.chat),
          _buildItem(TabItem.people),
          _buildItem(TabItem.random),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (BuildContext context, int index) {
        final item = TabItem.values[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: CupertinoTabView(
            navigatorKey: navigatorKey[item],
            builder: (context) => widgetBuilders[item](context),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allData[tabItem];
    final color = currentTab == tabItem ? blueColor : greyColor;

    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allData = {
    TabItem.chat: TabItemData(
      title: 'Chat',
      icon: Icons.chat_bubble,
    ),
    TabItem.people: TabItemData(
      title: 'People',
      icon: Icons.person,
    ),
    TabItem.random: TabItemData(
      title: 'Random',
      icon: Icons.question_answer,
    ),
  };
}
