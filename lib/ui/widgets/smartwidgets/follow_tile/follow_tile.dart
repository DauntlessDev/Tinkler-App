import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/widgets/smartwidgets/follow_tile/follow_tile_viewmodel.dart';

import '../../avatar.dart';

class FollowTile extends StatelessWidget {
  const FollowTile({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowTileViewModel>.reactive(
      onModelReady: (model) =>
          model.isProfileFollowed(profile.email, profile.followers),
      viewModelBuilder: () => FollowTileViewModel(),
      builder: (context, model, child) => ListTile(
        leading: GestureDetector(
            onTap: () => model.visitProfile(profile.email),
            child: Avatar(photoUrl: profile.photoUrl, radius: 30)),
        title: GestureDetector(
            onTap: () => model.visitProfile(profile.email),
            child: Text(profile.displayName)),
        subtitle: Text(profile.email),
        trailing: Container(
          decoration: new BoxDecoration(
              color: model.isOwnProfile
                  ? Colors.grey[600]
                  : model.isFollowed
                      ? Colors.blue[300]
                      : Theme.of(context).primaryColor,
              borderRadius: new BorderRadius.all(const Radius.circular(3.0))),
          width: 90,
          height: 50,
          child: FlatButton(
            onPressed:
                model.buttonFunction(email: profile.email, uid: profile.uid),
            child: Text(
              model.buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
