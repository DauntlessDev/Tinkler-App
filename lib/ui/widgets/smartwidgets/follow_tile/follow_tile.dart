

import 'package:flutter/material.dart';
import 'package:tinkler/model/profile.dart';

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
    return ListTile(
      onTap: visitProfile,
      leading: Avatar(photoUrl: profile.photoUrl, radius: 30),
      title: Text(profile.displayName),
      subtitle: Text(profile.email),
      trailing: Container(
        color: Theme.of(context).primaryColor,
        height: 50,
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'follow',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
