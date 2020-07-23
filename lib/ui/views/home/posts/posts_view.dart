//view class
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/home/posts/post_bottomsheet/post_bottomsheet_view.dart';

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
    List<Widget> postList = [
      PostTile(),
      SizedBox(height: 15),
      PostTile(),
      SizedBox(height: 15),
      PostTile(),
    ];

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
                          child: ListView(
                            children: postList,
                          ),
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

class PostTile extends StatelessWidget {
  const PostTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/profile_1.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Brave Leuterio',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Text('4 mins ago', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Spacer(flex: 1),
                  Icon(Icons.menu, size: 20),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'The black currawong (Strepera fuliginosa), also known as the black jay, is a large passerine bird endemic to Tasmania and nearby islands in the Bass Strait. ',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 13),
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
