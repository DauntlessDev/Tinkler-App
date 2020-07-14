import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:tinkler/model/message.dart';
import 'package:tinkler/ui/shared/list_item_builder.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

import 'chatroom_viewmodel.dart';

class ChatroomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatroomViewModel>.reactive(
      viewModelBuilder: () => ChatroomViewModel(),
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Row(children: [
              Avatar(photoUrl: model.otherPhotoUrl, radius: 20),
              SizedBox(
                width: 10,
              ),
              Text(model.otherDisplayName)
            ]),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MessageBuilder(),
                InputMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputMessage extends HookViewModelWidget<ChatroomViewModel> {
  const InputMessage({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, ChatroomViewModel model) {
    var messageTextController = useTextEditingController();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
              child: TextField(
                controller: messageTextController,
                onChanged: model.setInput,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              model.sendMessage();
              messageTextController.clear();
            },
            child: Text(
              'Send',
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBuilder extends ViewModelWidget<ChatroomViewModel> {
  MessageBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, ChatroomViewModel model) {
    List<Message> messages = model.messages;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MessageBubble(
              ifUser: model.isUser(messages[index].sender),
              sender: messages[index].sender,
              // isLastSend: messages[index+1].sender,
              text: messages[index].message,
              isLastSend: index == 0
                  ? true
                  : model.isLastSend(
                      sender: messages[index].sender,
                      nextSender: messages[index - 1].sender,
                    ));
        },
        itemCount: messages.length,
        reverse: true,
      ),
    );
  }
}
// child: ListItemBuilder<Message>(
//   model: model,
//   items: model.data,
//   itemBuilder: (context, message) => MessageBubble(
//     ifUser: model.isUser(message.sender),
//     sender: message.sender,
//     text: message.message,
//     nextSender: message.
//   ),
// ),

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key key,
    @required this.sender,
    @required this.text,
    @required this.ifUser,
    @required this.isLastSend,
  }) : super(key: key);

  final String sender;
  final String text;
  final bool ifUser;
  final bool isLastSend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment:
            ifUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          !ifUser & isLastSend
              ? Avatar(
                  photoUrl: '',
                  radius: 17,
                )
              : SizedBox(width: 32),
          Material(
            color: ifUser ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: isLastSend
                  ? ifUser ? Radius.circular(15) : Radius.circular(0)
                  : Radius.circular(15),
              topRight: isLastSend
                  ? ifUser ? Radius.circular(0) : Radius.circular(15)
                  : Radius.circular(15),
            ),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                this.text,
                style: TextStyle(
                  color: ifUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
