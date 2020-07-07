//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/centered_circular_indicator.dart';

import 'auth/login/login_view.dart';
import 'home/home_view.dart';
import 'landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      builder: (context, model, child) {
        if (!model.isBusy)
          return (model.user == null) ? LoginView() : HomeView();
        else
          return CenteredCircularIndicator();
      },
      viewModelBuilder: () => LandingViewModel(),
    );
  }
}
