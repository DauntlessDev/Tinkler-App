import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/shared/fullpicture/fullpicture_viewmodel.dart';

import 'following_info_viewmodel.dart';

class FollowingInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FollowingInfoViewModel>.reactive(
        viewModelBuilder: () => FollowingInfoViewModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Text('Following'),
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.3)),
          body: SafeArea(
            child: Container(),
          ),
        ),
      );
}
