//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'posts_viewmodel.dart';

class PostsView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.nonReactive(
      builder: (context, model, child) => _MainContent(),
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
    return Scaffold();
  }
}
