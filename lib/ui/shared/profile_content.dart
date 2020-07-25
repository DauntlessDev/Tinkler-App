//view class
import 'package:flutter/material.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/shared/avatar.dart';
import 'package:tinkler/ui/shared/post_tile.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    Key key,
    @required this.profile,
    @required this.buttonText,
    @required this.onPressed,
    @required this.ownPostsList,
  }) : super(key: key);

  final Profile profile;
  final String buttonText;
  final Function onPressed;
  final List<Post> ownPostsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 7, 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _ProfileHeader(
              buttonText: buttonText,
              onPressed: onPressed,
              profile: profile,
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  Icon(Icons.pages),
                  Text(' Posts'),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              height: 1,
              child: Container(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          OwnPostListBuilder(ownPostsList: ownPostsList),
        ],
      ),
    );
  }
}

class OwnPostListBuilder extends StatelessWidget {
  const OwnPostListBuilder({
    Key key,
    @required this.ownPostsList,
  }) : super(key: key);

  final List<Post> ownPostsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          itemBuilder: (context, index) => PostTile(post: ownPostsList[index]),
          itemCount: ownPostsList.length,
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key key,
    @required this.profile,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  final Profile profile;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Avatar(photoUrl: profile.photoUrl, radius: 50),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                profile.displayName ?? '',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(profile.email,
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
                  _ProfileStats(number: profile.posts, label: 'posts'),
                  _ProfileStats(number: profile.followers, label: 'followers'),
                  _ProfileStats(number: profile.following, label: 'following'),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.maxFinite,
                  color: Theme.of(context).primaryColor,
                  child: FlatButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
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
