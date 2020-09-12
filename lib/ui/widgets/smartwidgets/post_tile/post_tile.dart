import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/theme/app_theme_service.dart';
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
      builder: (context, model, child) => OptionalDismiss(
        ownPost: model.checkIfOwnPost(postprofile.post.posterEmail),
        postId: postprofile.post.postId,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          Text(
                            ' • ${model.formatDate(postprofile.post.time)}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        postprofile.posterProfile.email,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      Text(
                        postprofile.post.description,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      if (postprofile.post.pictureUrl.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            model.updateCurrentImageUrl(
                                postprofile.post.pictureUrl);
                            model.navigateToPictureView();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.0),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  postprofile.post.pictureUrl),
                              fit: BoxFit.fitWidth,
                              // width: double.minPositive,
                              width: MediaQuery.of(context).size.width * .6,
                              // height: 200,
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            onPressed:
                                model.onPressedLikeButton(postprofile.post),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  model.isLiked
                                      ? Icon(MdiIcons.heart,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          size: 18)
                                      : Icon(MdiIcons.heartOutline,
                                          color: Colors.grey, size: 18),
                                  SizedBox(width: 1),
                                  AutoSizeText(
                                      model.likesText(model.likesCount),
                                      style: TextStyle(
                                          color: model.isLiked
                                              ? Theme.of(context)
                                                  .iconTheme
                                                  .color
                                              : Colors.grey,
                                          fontSize: 10)),
                                ],
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: model.navigateToCommentSection,
                            child: Container(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(MdiIcons.chatOutline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      size: 18),
                                  SizedBox(width: 1),
                                  AutoSizeText(
                                      model.commentText(
                                          postprofile.post.commentsCount),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontSize: 10)),
                                ],
                              ),
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
      ),
    );
  }
}

class OptionalDismiss extends ViewModelWidget<PostTileViewModel> {
  final bool ownPost;
  final Widget child;
  final String postId;

  const OptionalDismiss({
    Key key,
    @required this.ownPost,
    @required this.child,
    @required this.postId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, PostTileViewModel model) {
    return ownPost
        ? Dismissible(
            background: Container(
              color: AppThemeService.isDarkModeOn
                  ? Colors.grey[700]
                  : Colors.blueGrey[100],
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete,
                    color: AppThemeService.isDarkModeOn
                        ? Colors.white
                        : Theme.of(context).iconTheme.color),
              ),
            ),
            onDismissed: (direction) => model.deletePost(postId),
            key: Key('post-$postId'),
            child: child)
        : Container(
            child: child,
          );
  }
}
