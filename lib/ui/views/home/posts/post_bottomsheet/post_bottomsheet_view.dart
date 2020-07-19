//view class
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'post_bottomsheet_viewmodel.dart';

class PostBottomsheetView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostBottomsheetViewModel>.nonReactive(
      builder: (context, model, child) => const _MainContent(),
      viewModelBuilder: () => PostBottomsheetViewModel(),
    );
  }
}

class _MainContent extends ViewModelWidget<PostBottomsheetViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, PostBottomsheetViewModel model) {
    return Container(
      height: 350,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(),
      ),
    );
  }
}
