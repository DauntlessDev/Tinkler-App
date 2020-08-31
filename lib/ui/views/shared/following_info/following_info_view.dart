import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/independent_scale.dart';
import 'package:tinkler/ui/widgets/smartwidgets/follow_tile/follow_tile.dart';

import 'following_info_viewmodel.dart';

class FollowingInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FollowingInfoViewModel>.reactive(
        viewModelBuilder: () => FollowingInfoViewModel(),
        builder: (context, model, child) => IndependentScale(
                  child: Scaffold(
            appBar: AppBar(title: Text('Following')),
            body: SafeArea(
              child: _FollowTileBuilder(),
            ),
          ),
        ),
      );
}

class _FollowTileBuilder extends ViewModelWidget<FollowingInfoViewModel> {
  _FollowTileBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, FollowingInfoViewModel model) {
    print('follow tile built');
    if (model.followedProfileList == null) return Container();
    if (model.followedProfileList.isEmpty)
      return EmptyContent(
          title: 'Empty Result', message: 'User is not following anyone.');

    return ListView.builder(
      itemBuilder: (context, index) {
        Profile currentProfile = model.followedProfileList[index];

        return FollowTile(
          profile: currentProfile,
        );
      },
      itemCount: model.followedProfileList.length,
    );
  }
}
