//view class
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/theme/app_theme_service.dart';
import 'package:tinkler/ui/shared/avatar.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.profile == null || model.isBusy,
          child: _MainContent()),
    );
  }
}

class _MainContent extends ViewModelWidget<ProfileViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: true);

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
        actions: <Widget>[ProfileMenu()],
      ),
      body: _ProfileContent(),
    );
  }
}

class ProfileMenu extends ViewModelWidget<ProfileViewModel> {
  ProfileMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    final List<Option> _optionList = [
      Option(
          title: 'Dark Mode',
          iconData: MdiIcons.moonWaningCrescent,
          onTap: model.toggleDarkMode,
          isSwitch: true),
      Option(title: 'Notifications', iconData: MdiIcons.bell, onTap: () {}),
      Option(title: 'Logout', iconData: Icons.exit_to_app, onTap: model.signOut)
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        cardColor:
            AppThemeService.isDarkModeOn ? Colors.grey[900] : Colors.white,
      ),
      child: PopupMenuButton(
        icon: Icon(Icons.menu),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<_OptionTile>>[
          PopupMenuItem<_OptionTile>(
            child: _OptionTile(
              option: _optionList[0],
            ),
          ),
          PopupMenuItem<_OptionTile>(
            child: _OptionTile(
              option: _optionList[1],
            ),
          ),
          PopupMenuItem<_OptionTile>(
            child: _OptionTile(
              option: _optionList[2],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileContent extends ViewModelWidget<ProfileViewModel> {
  const _ProfileContent({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 7, 7),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          _ProfileHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              height: 1,
              child: Container(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Icon(Icons.pages),
                  Text('yes'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileHeader extends ViewModelWidget<ProfileViewModel> {
  const _ProfileHeader({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Avatar(photoUrl: model.profile.photoUrl, radius: 50),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                model.profile.displayName ?? '',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(model.profile.email,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAx,
                children: <Widget>[
                  _ProfileStats(number: 12, label: 'posts'),
                  _ProfileStats(number: 243, label: 'followers'),
                  _ProfileStats(number: 187, label: 'following'),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.maxFinite,
                  color: Theme.of(context).primaryColor,
                  child: FlatButton(
                    onPressed: model.changeProfile,
                    child: Text('Change Picture'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileStats extends StatelessWidget {
  const _ProfileStats({
    Key key,
    @required this.number,
    @required this.label,
  }) : super(key: key);

  final int number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$number',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            )),
        Text(label, style: TextStyle(fontSize: 11)),
      ],
    );
  }
}

class Option {
  final String title;
  final IconData iconData;
  final String subTitle;
  final String category;
  final bool isSwitch;
  final Function onTap;

  Option(
      {@required this.title,
      @required this.iconData,
      this.subTitle,
      this.category,
      this.isSwitch = false,
      @required this.onTap});
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({Key key, @required this.option}) : super(key: key);
  final Option option;

  @override
  Widget build(BuildContext context) {
    return option.isSwitch
        ? SwitchListTile(
            secondary: Icon(
              option.iconData,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(option.title),
            onChanged: option.onTap,
            value: AppThemeService.isDarkModeOn,
          )
        : ListTile(
            leading: Icon(
              option.iconData,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(option.title),
            onTap: option.onTap,
          );
  }
}
