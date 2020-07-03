//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'random_viewmodel.dart';

class RandomView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => RandomViewModel(),
    );
  }
}
