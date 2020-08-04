//view class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        child: _MainContent(),
      ),
    );
  }
}

class _MainContent extends ViewModelWidget<ChatViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: true);

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
      ),
      // body: Container(),
      body: MessageList(),
      floatingActionButton: FloatingActionButton(
        heroTag: "chatFab",
        onPressed: model.navigateToSearch,
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
    print('all chats ${model.listOfAllChats}');
    if (model.listOfAllChats == null) return EmptyContent();
    return ListView.builder(
      itemCount: model.listOfAllChats.length,
      itemBuilder: (context, index) => MessageTile(
        chat: model.listOfAllChats[index],
        startConversation: model.startConversation,
      ),
    );
  }
}

class MessageTile extends ViewModelWidget<ChatViewModel> {
  const MessageTile({
    Key key,
    @required this.chat,
    @required this.startConversation,
  }) : super(key: key, reactive: true);

  final Chat chat;
  final Function startConversation;

  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Dismissible(
      background: Container(
        color: Colors.blueGrey[100],
        padding: EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete),
        ),
      ),
      onDismissed: (direction) => model.deleteChatroom(chat.profile.email),
      key: Key('chat-${model.getChatroomID(chat.profile.email)}'),
      child: ListTile(
        onTap: () => startConversation(chat.profile),
        leading: Avatar(
          radius: 20,
          photoUrl: chat.profile.photoUrl,
        ),
        title: Text(
          chat.profile.displayName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: RichText(
          text: TextSpan(
            style: Theme.of(context).primaryTextTheme.subtitle1,
            children: [
              TextSpan(text: chat.lastMessage.message),
              TextSpan(
                text: ' • ${model.formatDate(chat.lastMessage.time)}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
