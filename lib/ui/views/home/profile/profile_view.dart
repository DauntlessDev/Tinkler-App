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
          actions: <Widget>[
            ProfileMenu(),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(240),
            child: _BottomAppBarProfile(),
          )),
      body: Container(),
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

class _BottomAppBarProfile extends ViewModelWidget<ProfileViewModel> {
  const _BottomAppBarProfile({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(children: [
              Avatar(photoUrl: model.profile.photoUrl, radius: 60),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: model.changeProfile,
                    child: Icon(MdiIcons.camera,
                        size: 25,
                        color: AppThemeService.isDarkModeOn
                            ? Colors.white
                            : Colors.black),
                  ))
            ]),
            const SizedBox(height: 15),
            Text(
              model.profile.displayName ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 5),
            Text(model.profile.email,
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

// class _OptionListBuilder extends ViewModelWidget<ProfileViewModel> {
//   const _OptionListBuilder({
//     Key key,
//   }) : super(key: key, reactive: false);

//   @override
//   Widget build(BuildContext context, ProfileViewModel model) {
//     final List<Option> _optionList = [
//       Option(
//           title: 'Dark Mode',
//           iconData: MdiIcons.moonWaningCrescent,
//           onTap: model.toggleDarkMode,
//           isSwitch: true),
//       Option(title: 'Notifications', iconData: MdiIcons.bell, onTap: () {}),
//       Option(title: 'App Updates', iconData: Icons.file_download, onTap: () {}),
//       Option(title: 'Logout', iconData: Icons.exit_to_app, onTap: model.signOut)
//     ];

//     return ListView.builder(
//         itemBuilder: (context, index) =>
//             _OptionTile(option: _optionList[index]),
//         itemCount: _optionList.length);
//   }
// }
