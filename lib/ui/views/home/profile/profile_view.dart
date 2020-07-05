//view class
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/avatar.dart';

import '../../../../constants.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      builder: (context, model, child) {
        return const _MainContent();
      },
      viewModelBuilder: () => ProfileViewModel(),
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
      backgroundColor: whiteColor,
      appBar: AppBar(
          elevation: 1,
          backgroundColor: whiteColor,
          title: Row(
            children: [
              const Text(
                'Profile ',
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const Icon(
                Icons.person,
                color: blackColor,
              ),
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
            Avatar(photoUrl: model.userPhotoUrl, radius: 60),
            const SizedBox(height: 15),
            const Text(
              'Rom Braveheart P. Leuterio',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('Flutter developer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({Key key, @required this.option}) : super(key: key);
  final Option option;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        option.iconData,
        color: darkBlueColor,
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
      Option(
          title: 'Notifications & Sounds',
          iconData: MdiIcons.bell,
          onTap: () {}),
      Option(title: 'App Updates', iconData: Icons.file_download, onTap: () {}),
      Option(
          title: 'Logout', iconData: Icons.exit_to_app, onTap: model.signOut),
    ];
    return ListView.builder(
        itemBuilder: (context, index) {
          return _OptionTile(option: _optionList[index]);
        },
        itemCount: _optionList.length);
  }
}
