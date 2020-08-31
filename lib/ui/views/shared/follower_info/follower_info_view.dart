import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/independent_scale.dart';
import 'package:tinkler/ui/widgets/smartwidgets/follow_tile/follow_tile.dart';

import 'follower_info_viewmodel.dart';

class FollowerInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FollowerInfoViewModel>.reactive(
        viewModelBuilder: () => FollowerInfoViewModel(),
        builder: (context, model, child) => IndependentScale(
          child: Scaffold(
            appBar: AppBar(title: Text('Followers')),
            body: SafeArea(
              child: _FollowTileBuilder(),
            ),
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
          title: 'Empty Result', message: 'User is not followed by anyone.');

    return ListView.builder(
      itemBuilder: (context, index) {
        Profile currentProfile = model.followersProfileList[index];

        return FollowTile(
          profile: currentProfile,
        );
      },
      itemCount: model.followersProfileList.length,
    );
  }
}
