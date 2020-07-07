//view class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/ui/shared/list_item_builder.dart';

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, model, child) => _MainContent(),
    );
  }
}

class _MainContent extends ViewModelWidget<ChatViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text('Messages',
                style: Theme.of(context).appBarTheme.textTheme.headline1),
            const RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right)),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //TODO: Add search
            },
            child: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: MessageList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
      ),
    );
  }
}

class MessageList extends ViewModelWidget<ChatViewModel> {
  const MessageList({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return ListItemBuilder<Chat>(
      model: model,
      itemBuilder: (context, chat) => MessageTile(chat: chat),
      divider: Divider(),
      items: model.list,
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({
    Key key,
    @required this.chat,
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        child: ClipOval(
          child: Image(
            image: AssetImage(chat.photoUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text(
        chat.name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: RichText(
        text: TextSpan(
          style: Theme.of(context).primaryTextTheme.subtitle1,
          children: [
            TextSpan(text: chat.latestMessage),
            TextSpan(
              text: ' • ${chat.time}',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue[900],
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            '12',
            style: TextStyle(color: Colors.white, fontSize: 9),
          ),
        ),
      ),
    );
  }
}
