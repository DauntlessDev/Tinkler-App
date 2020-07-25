import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

import 'avatar.dart';

class PostTile extends StatelessWidget {
  PostTile({
    Key key,
    @required this.post,
  });

  final Post post;
  final _formatter = locator<FormatterService>();

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
                        radius: 25, photoUrl: post.posterProfile.photoUrl)),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        post.posterProfile.displayName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 11),
                      ),
                      Text(
                        ' • ${_formatter.formatPostDate(post.time)}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      // Expanded(child: Container()),
                      // Icon(Icons.menu, size: 15),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    post.posterProfile.email,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  SizedBox(height: 10),
                  Text(
                    post.description,
                    style: TextStyle(fontSize: 12),
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
