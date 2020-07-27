import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/smartwidgets/follow_tile/follow_tile.dart';

import 'follower_info_viewmodel.dart';

class FollowerInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FollowerInfoViewModel>.reactive(
        viewModelBuilder: () => FollowerInfoViewModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Text('Followers'),
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.3)),
          body: SafeArea(
            child: _FollowTileBuilder(),
          ),
        ),
      );
}

class _FollowTileBuilder extends ViewModelWidget<FollowerInfoViewModel> {
  _FollowTileBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, FollowerInfoViewModel model) {
    if (model.followersProfileList == null) return Container();
    if (model.followersProfileList.isEmpty)
      return EmptyContent(
          title: 'Empty Result', message: 'You are not followed by anyone.');

    return ListView.builder(
      itemBuilder: (context, index) => FollowTile(
        profile: model.followersProfileList[index],
        visitProfile: () =>
            model.visitProfile(model.followersProfileList[index].email),
      ),
      itemCount: model.followersProfileList.length,
    );
  }
}
