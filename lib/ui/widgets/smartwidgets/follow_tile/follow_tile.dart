import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/widgets/smartwidgets/follow_tile/follow_tile_viewmodel.dart';

import '../../avatar.dart';

class FollowTile extends StatelessWidget {
  const FollowTile({
    Key key,
    @required this.profile,
    @required this.visitProfile,
  }) : super(key: key);

  final Profile profile;
  final Function visitProfile;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => FollowTileViewModel(),
      builder: (context, model, child) => ListTile(
        onTap: visitProfile,
        leading: Avatar(photoUrl: profile.photoUrl, radius: 30),
        title: Text(profile.displayName),
        subtitle: Text(profile.email),
        trailing: Container(
          color: model.isProfileFollowed(profile.email)
              ? Colors.blue[300]
              : Theme.of(context).primaryColor,
          height: 50,
          child: FlatButton(
            onPressed: model.onPressed(
                email: profile.email,
                uid: profile.uid),
            child: Text(
              model.buttonText(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
