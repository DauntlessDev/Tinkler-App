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
        final List<Option> _optionList = [
          Option(
              title: 'Story',
              icon: Icon(
                MdiIcons.collage,
                color: darkBlueColor,
              ),
              onTap: () {}),
          Option(
              title: 'Notifications & Sounds',
              icon: Icon(
                MdiIcons.bell,
                color: darkBlueColor,
              ),
              onTap: () {}),
          Option(
              title: 'App Updates',
              icon: Icon(
                Icons.file_download,
                color: darkBlueColor,
              ),
              onTap: () {}),
          Option(
            title: 'Logout',
            icon: Icon(
              Icons.exit_to_app,
              color: darkBlueColor,
            ),
            onTap: model.signOut,
          ),
        ];

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
              bottom:  PreferredSize(
                preferredSize: const Size.fromHeight(240),
                child: Padding(
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
                        const Text('Flutter developer'),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              )),
          body: ListView.builder(
              itemBuilder: (context, index) {
                return OptionTile(option: _optionList[index]);
              },
              itemCount: _optionList.length),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({Key key, @required this.option}) : super(key: key);
  final Option option;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: option.icon,
      title: Text(option.title),
      onTap: option.onTap,
    );
  }
}
