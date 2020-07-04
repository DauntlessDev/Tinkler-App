//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: blueColor,
          actions: <Widget>[
            FlatButton(
              onPressed: model.signOut,
              child: Text(
                'Logout',
                style: whiteTextStyle,
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
