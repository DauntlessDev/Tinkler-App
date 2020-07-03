//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/avatar.dart';

import '../../../../constants.dart';
import 'people_viewmodel.dart';

class PeopleView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PeopleViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Avatar(
              radius: 20,
              photoUrl: model.user.photoUrl,
            ),
          ),
          title: Text('People'),
          backgroundColor: blueColor,
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text(
                'Find',
                style: whiteTextStyle,
              ),
            )
          ],
          bottom: PreferredSize(
              child: Container(), preferredSize: Size.fromHeight(50)),
        ),
      ),
      viewModelBuilder: () => PeopleViewModel(),
    );
  }
}
