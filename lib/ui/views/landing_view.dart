//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/auth/login/login_view.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/widgets/independent_scale.dart';

import 'landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      viewModelBuilder: () => LandingViewModel(),
      builder: (context, model, child) => IndependentScale(
              child: model.user == null ? LoginView() : HomeView(),
      ),
    );
  }
}
