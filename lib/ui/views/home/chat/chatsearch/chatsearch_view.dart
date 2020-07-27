import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

import 'chatsearch_viewmodel.dart';

class ChatSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatSearchViewModel>.reactive(
      viewModelBuilder: () => ChatSearchViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: model.setInput,
            onEditingComplete: model.searchUsers,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: model.searchUsers,
              child: Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: model.isBusy,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _SearchTileBuilder(),
          ),
        ),
      ),
    );
  }
}

class _SearchTileBuilder extends ViewModelWidget<ChatSearchViewModel> {
  _SearchTileBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ChatSearchViewModel model) {
    if (model.listOfUsers == null) return Container();
    if (model.listOfUsers.isEmpty)
      return EmptyContent(
          title: 'Empty Result', message: 'The name entered is not found.');

    return ListView.builder(
      itemBuilder: (context, index) => _SearchTile(
        profile: model.listOfUsers[index],
        sendMessage: () => model.startConversation(model.listOfUsers[index]),
      ),
      itemCount: model.listOfUsers.length,
    );
  }
}

class _SearchTile extends StatelessWidget {
  const _SearchTile({
    Key key,
    @required this.profile,
    @required this.sendMessage,
  }) : super(key: key);

  final Profile profile;
  final Function sendMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: sendMessage,
      leading: Avatar(photoUrl: profile.photoUrl, radius: 30),
      title: Text(profile.displayName),
    );
  }
}
