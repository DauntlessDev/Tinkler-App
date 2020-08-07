//view class
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/theme/app_theme_service.dart';
import 'package:tinkler/ui/widgets/smartwidgets/profile_content/profile_content.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.profile.email.isEmpty || model.isBusy,
          child: model.profile.email.isEmpty
              ? Container(color: Theme.of(context).backgroundColor)
              : _MainContent()),
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
      body: ProfileContent(
        buttonText: 'Change Picture',
        onPressed: model.changeProfile,
        ownPostsList: model.ownPostProfileList,
        profile: model.profile,
        buttonColor: Theme.of(context).primaryColor,
      ),
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
