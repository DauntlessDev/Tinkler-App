//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/shared/centered_circular_indicator.dart';

import 'home/home_view.dart';
import 'landing_viewmodel.dart';
import 'login/login_view.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      builder: (context, model, child) {
        if (!model.isBusy) {
          if (model.user == null) {
            return LoginView();
          } else {
            return HomeView();
          }
        } else {
          return CenteredCircularIndicator();
        }
      },
      viewModelBuilder: () => LandingViewModel(),
    );
  }
}
