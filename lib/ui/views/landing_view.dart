//view class
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';

import 'landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      onModelReady: (model) => model.subscribeToAuthStateChanged(),
      builder: (context, model, child) =>
          ModalProgressHUD(inAsyncCall: model.isBusy, child: Scaffold()),
      viewModelBuilder: () => LandingViewModel(),
    );
  }
}
