import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/shared/empty_content.dart';

import 'chatroom_viewmodel.dart';

class ChatroomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatroomViewModel>.reactive(
      viewModelBuilder: () => ChatroomViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(''),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageBuilder(),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                        child: TextField(onChanged: model.setInput),
                      ),
                    ),
                    FlatButton(
                      onPressed: model.sendMessage,
                      child: Text(
                        'Send',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
    // if (model.listOfUsers == null) return Container();
    // if (model.listOfUsers.isEmpty)
    //   return EmptyContent(
    //       title: 'Empty Chat', message: 'No messages found.');

    return Expanded(
      child: Container(),
      //   child: ListView.builder(
      // itemBuilder: (context, index) =>
      //     MessageBubble(sender: model.listOfUsers[index]),
      // itemCount: model.listOfUsers.length,
      // ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    @required this.sender,
    @required this.text,
    @required this.ifUser,
  });

  final String sender;
  final String text;
  final bool ifUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            ifUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.sender,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Material(
            color: ifUser ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: ifUser ? Radius.circular(20) : Radius.circular(0),
              topRight: ifUser ? Radius.circular(0) : Radius.circular(20),
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
