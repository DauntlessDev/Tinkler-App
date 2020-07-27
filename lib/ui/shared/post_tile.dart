import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/services/state_services/current_picture_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

import 'avatar.dart';

class PostTile extends StatelessWidget {
  PostTile({
    Key key,
    @required this.postprofile,
  }) : super(key: key);

  final PostProfile postprofile;
  final _formatter = locator<FormatterService>();
  final _currentPicture = locator<CurrentPictureService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Avatar(
                        radius: 25,
                        photoUrl: postprofile.posterProfile.photoUrl)),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        postprofile.posterProfile.displayName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 11),
                      ),
                      Text(
                        ' • ${_formatter.formatPostDate(postprofile.post.time)}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    postprofile.posterProfile.email,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  SizedBox(height: 10),
                  Text(
                    postprofile.post.description,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  if (postprofile.post.pictureUrl.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _currentPicture
                            .updateCurrentImageUrl(postprofile.post.pictureUrl);
                        _currentPicture.navigateToPictureView();
                      },
                      child: Image(
                        image: NetworkImage(postprofile.post.pictureUrl),
                        fit: BoxFit.fitWidth,
                        width: 250,
                        height: 200,
                      ),
                    ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(MdiIcons.heart,
                                color: Theme.of(context).iconTheme.color,
                                size: 18),
                            Text(' 25 Likes',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(MdiIcons.chatOutline,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                size: 18),
                            Text('13 Comments',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
