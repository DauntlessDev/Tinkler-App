import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/ui/widgets/smartwidgets/post_tile/post_title_viewmodel.dart';
import '../../avatar.dart';

class PostTile extends StatelessWidget {
  PostTile({
    Key key,
    @required this.postprofile,
  }) : super(key: key);

  final PostProfile postprofile;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostTileViewModel>.reactive(
      onModelReady: (model) => model.checkIfLike(
        postprofile.post.postId,
        postprofile.post,
      ),
      viewModelBuilder: () => PostTileViewModel(),
      builder: (context, model, child) => Padding(
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
                          ' • ${model.formatDate(postprofile.post.time)}',
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
                          model.updateCurrentImageUrl(
                              postprofile.post.pictureUrl);
                          model.navigateToPictureView();
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
                        FlatButton(
                          onPressed:
                              model.onPressedLikeButton(postprofile.post),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(MdiIcons.heart,
                                    color: model.isLiked
                                        ? Theme.of(context).iconTheme.color
                                        : Colors.grey,
                                    size: 18),
                                SizedBox(width: 2),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                      model.likesText(
                                          postprofile.post.likesCount),
                                      style: TextStyle(
                                          color: model.isLiked
                                              ? Theme.of(context)
                                                  .iconTheme
                                                  .color
                                              : Colors.grey,
                                          fontSize: 10)),
                                ),
                              ],
                            ),
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
                              SizedBox(width: 2),
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
      ),
    );
  }
}
