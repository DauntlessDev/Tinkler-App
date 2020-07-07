//view class
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => const _MainContent(),
    );
  }
}

class _MainContent extends ViewModelWidget<ProfileViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Row(
            children: [
              Text(
                'Profile ',
                style: Theme.of(context).appBarTheme.textTheme.headline1,
              ),
              const Icon(Icons.person),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(240),
            child: _BottomAppBarProfile(),
          )),
      body: _OptionListBuilder(),
    );
  }
}

class _BottomAppBarProfile extends ViewModelWidget<ProfileViewModel> {
  const _BottomAppBarProfile({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Avatar(photoUrl: 'assets/images/profile_1.jpg', radius: 60),
            const SizedBox(height: 15),
            Text(
              'Rom Braveheart P. Leuterio',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 5),
            const Text('Flutter developer',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class Option {
  final String title;
  final IconData iconData;
  final String subTitle;
  final String category;
  final Function onTap;

  Option(
      {@required this.title,
      @required this.iconData,
      this.subTitle,
      this.category,
      @required this.onTap});
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({Key key, @required this.option}) : super(key: key);
  final Option option;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        option.iconData,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(option.title),
      onTap: option.onTap,
    );
  }
}

class _OptionListBuilder extends ViewModelWidget<ProfileViewModel> {
  const _OptionListBuilder({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    final List<Option> _optionList = [
      Option(title: 'Story', iconData: MdiIcons.collage, onTap: () {}),
      Option(title: 'Notifications', iconData: MdiIcons.bell, onTap: () {}),
      Option(title: 'App Updates', iconData: Icons.file_download, onTap: () {}),
      Option(title: 'Logout', iconData: Icons.exit_to_app, onTap: model.signOut)
    ];

    return ListView.builder(
        itemBuilder: (context, index) =>
            _OptionTile(option: _optionList[index]),
        itemCount: _optionList.length);
  }
}
