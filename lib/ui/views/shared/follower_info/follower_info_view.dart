import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
            child: Container(),
          ),
        ),
      );
}
