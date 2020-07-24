//view class
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/ui/shared/empty_content.dart';
import 'package:tinkler/ui/views/home/posts/post_bottomsheet/post_bottomsheet_view.dart';
import 'package:tinkler/ui/shared/avatar.dart';

import 'posts_viewmodel.dart';

class PostsView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.nonReactive(
      builder: (context, model, child) => const _MainContent(),
      viewModelBuilder: () => PostsViewModel(),
    );
  }
}

class _MainContent extends ViewModelWidget<PostsViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, PostsViewModel model) {
    // List<Widget> postList = [
    //   PostTile(),
    //   SizedBox(height: 15),
    //   PostTile(),
    //   SizedBox(height: 15),
    //   PostTile(),
    // ];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "postFab",
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return PostBottomsheetView();
              }),
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Latest Posts', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 20),
                        Expanded(
                          flex: 1,
                          child: PostListBuilder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class PostListBuilder extends ViewModelWidget<PostsViewModel> {
  const PostListBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, PostsViewModel model) {
    if (model.postList == null)
      return EmptyContent();
    else if (model.postList.isEmpty)
      return EmptyContent(
        title: 'Post Empty',
        message: 'Follow other users.',
      );
    return ListView.builder(
      itemCount: model.postList.length,
      itemBuilder: (context, index) => PostTile(
        post: model.postList[index],
        // startConversation: model.startConversation,
      ),
    );
  }
}

class PostTile extends ViewModelWidget<PostsViewModel> {
  const PostTile({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, PostsViewModel model) {
    double descriptionFontSize = 13;
    if (post.description.length < 10)
      descriptionFontSize = 25;
    else if (post.description.length < 15) descriptionFontSize = 17;
    return ClipRRect(
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
                        model.formatTime(post.time),
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
                              image: AssetImage('assets/images/profile_1.jpg'),
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
                            color: Theme.of(context).iconTheme.color, size: 18),
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
    );
  }
}
