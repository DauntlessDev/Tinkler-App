//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/avatar.dart';

import '../../../../constants.dart';
import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Avatar(
              radius: 20,
              photoUrl: model.userPhotoUrl,
            ),
          ),
          title: Text('Chat'),
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
          bottom: PreferredSize(
              child: Container(), preferredSize: Size.fromHeight(50)),
        ),
      ),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}
