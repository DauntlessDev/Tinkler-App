//view class
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/shared/empty_content.dart';
import 'package:tinkler/ui/shared/post_tile.dart';
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Latest Posts', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 20),
                        Expanded(
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
    return ListView.separated(
      itemCount: model.postList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == model.postList.length + 1)
          return Container();
        return PostTile(
          post: model.postList[index - 1],
          // startConversation: model.startConversation,
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey,
        thickness: .2,
        height: .2,
      ),
    );
  }
}
