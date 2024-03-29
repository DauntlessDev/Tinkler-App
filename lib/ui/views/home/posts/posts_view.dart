//view class
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/smartwidgets/post_tile/post_tile.dart';
import 'package:tinkler/ui/views/home/posts/post_bottomsheet/post_bottomsheet_view.dart';

import 'posts_viewmodel.dart';

class PostsView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => _MainContent(),
      viewModelBuilder: () => PostsViewModel(),
    );
  }
}

class _MainContent extends ViewModelWidget<PostsViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, PostsViewModel model) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "postFab",
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return PostBottomsheetView(reloadPost: model.reloadPage);
              }),
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: model.reloadPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text('Latest Posts',
                                    style: TextStyle(fontSize: 16)),
                                Spacer(),
                                FlatButton(
                                  onPressed: model.reloadPage,
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    MdiIcons.reload,
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 5),
                        Expanded(
                          child: model.isBusy
                              ? Center(child: CircularProgressIndicator())
                              : PostListBuilder(),
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
    if (model.postprofileList == null)
      return EmptyContent();
    else if (model.postprofileList.isEmpty)
      return EmptyContent(
        title: 'Post Empty',
        message: 'Follow other users.',
      );
    return ListView.separated(
      itemCount: model.postprofileList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == model.postprofileList.length + 1)
          return Container();
        return PostTile(
          postprofile: model.postprofileList[index - 1],
          // startConversation: model.startConversation,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        if (index != 0 && index % 6 == 0) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: AdmobBanner(
              adUnitId: model.getBannerAdUnitId(),
              adSize: AdmobBannerSize.FULL_BANNER,
            ),
          );
        } else {
          return Divider(
            color: Colors.grey,
            thickness: .2,
            height: .2,
          );
        }
      },
    );
  }
}
