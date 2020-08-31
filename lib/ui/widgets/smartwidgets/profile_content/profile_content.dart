//view class
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

import '../../avatar.dart';
import '../../empty_content.dart';
import '../post_tile/post_tile.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({
    Key key,
    @required this.profile,
    @required this.buttonText,
    @required this.buttonColor,
    @required this.onPressed,
    @required this.ownPostsList,
  }) : super(key: key);

  final Profile profile;
  final String buttonText;
  final Color buttonColor;
  final Function onPressed;
  final List<PostProfile> ownPostsList;

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  void dispose() {
    final _visitProfile = locator<VisitProfileService>();
    _visitProfile.removeVisitProfileEmail();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 7, 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _ProfileHeader(
              buttonText: widget.buttonText,
              onPressed: widget.onPressed,
              profile: widget.profile,
              buttonColor: widget.buttonColor,
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
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              height: 1,
            ),
          ),
          OwnPostListBuilder(ownPostsList: widget.ownPostsList),
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

  final List<PostProfile> ownPostsList;

  @override
  Widget build(BuildContext context) {
    print('ownPOstsLsist : ${ownPostsList.isEmpty}');
    if (ownPostsList.isEmpty) {
      return Expanded(
        child: SizedBox(
          height: 500,
          child: EmptyContent(
            title: 'Empty Posts',
            message: 'The user don\'t have any post.',
          ),
        ),
      );
    }
    return Expanded(
      child: SizedBox(
        height: 500,
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0 || index == ownPostsList.length + 1)
              return Container();
            return PostTile(postprofile: ownPostsList[index - 1]);
          },
          itemCount: ownPostsList.length + 2,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.grey,
            thickness: .2,
            height: .2,
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  _ProfileHeader({
    Key key,
    @required this.profile,
    @required this.buttonText,
    @required this.buttonColor,
    @required this.onPressed,
  }) : super(key: key);

  final Profile profile;
  final String buttonText;
  final Color buttonColor;
  final Function onPressed;

  final _navigation = locator<NavigationService>();
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
                  GestureDetector(
                      onTap: () =>
                          _navigation.navigateTo(Routes.followerInfoViewRoute),
                      child: _ProfileStats(
                          number: profile.followers, label: 'followers')),
                  GestureDetector(
                      onTap: () =>
                          _navigation.navigateTo(Routes.followingInfoViewRoute),
                      child: _ProfileStats(
                          number: profile.following, label: 'following')),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: onPressed == null ? Colors.grey : buttonColor,
                      borderRadius:
                          BorderRadius.all(const Radius.circular(3.0))),
                  child: FlatButton(
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        Text(label, style: TextStyle(fontSize: 13)),
      ],
    );
  }
}
