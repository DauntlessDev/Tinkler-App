//view class
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/profile_content.dart';

import 'checkprofile_viewmodel.dart';

class CheckProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckProfileViewModel>.reactive(
      viewModelBuilder: () => CheckProfileViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.profile.email.isEmpty || model.isBusy,
          child: model.profile.email.isEmpty
              ? Container(color: Theme.of(context).backgroundColor)
              : _MainContent()),
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
      ),
      body: ProfileContent(
        buttonText: model.buttonText(),
        onPressed: model.onPressed(),
        ownPostsList: model.ownPostProfileList,
        profile: model.profile,
        buttonColor: model.isFollowed
            ? Colors.blue[300]
            : Theme.of(context).primaryColor,
      ),
    );
  }
}
