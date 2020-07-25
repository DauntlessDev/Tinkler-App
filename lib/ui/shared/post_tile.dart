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
    double descriptionFontSize = 13;
    if (post.description.length < 10)
      descriptionFontSize = 25;
    else if (post.description.length < 15) descriptionFontSize = 17;
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Theme.of(context).colorScheme.onSurface,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Avatar(radius: 25, photoUrl: post.posterProfile.photoUrl),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.posterProfile.displayName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          _formatter.formatDate(post.time),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(flex: 1),
                    Icon(Icons.menu, size: 20),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  post.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: descriptionFontSize),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomLeft,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: CircleAvatar(
                              radius: 10,
                              child: ClipOval(
                                child: Image(
                                  image:
                                      AssetImage('assets/images/profile_2.jpg'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CircleAvatar(
                              radius: 10,
                              child: ClipOval(
                                child: Image(
                                  image:
                                      AssetImage('assets/images/profile_3.jpg'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 10,
                            child: ClipOval(
                              child: Image(
                                image:
                                    AssetImage('assets/images/profile_1.jpg'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Text('Connie and others like it.',
                          style: TextStyle(color: Colors.grey, fontSize: 10))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(),
                ),
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
                              color: Theme.of(context).colorScheme.onSecondary,
                              size: 18),
                          Text('13 Comments',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
