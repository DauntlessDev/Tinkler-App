//view class
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/shared/avatar.dart';

import 'checkprofile_viewmodel.dart';

class CheckProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckProfileViewModel>.reactive(
      viewModelBuilder: () => CheckProfileViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.profile == null || model.isBusy,
          child: _MainContent()),
    );
  }
}

class _MainContent extends ViewModelWidget<CheckProfileViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CheckProfileViewModel model) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Row(
            children: [
              Text(
                'Profile ',
                style: Theme.of(context).appBarTheme.textTheme.headline1,
              ),
              const Icon(Icons.person),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(240),
            child: _BottomAppBarProfile(),
          )),
      body: Container(),
    );
  }
}

class _BottomAppBarProfile extends ViewModelWidget<CheckProfileViewModel> {
  const _BottomAppBarProfile({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CheckProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Avatar(photoUrl: model.profile.photoUrl, radius: 60),
            const SizedBox(height: 15),
            Text(
              model.profile.displayName ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 5),
            Text(model.profile.email,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
