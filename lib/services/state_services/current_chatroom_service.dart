import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/user.dart';

@lazySingleton
class CurrentChatroomService extends ChangeNotifier {
  String _chatroomId;
  String get chatroomId => _chatroomId;

  List<String> _chatroomUsers;
  List<String> get chatroomUsers => _chatroomUsers;
  void updateCurrentChatroomId(Chatroom chatroom) {
    _chatroomId = chatroom.chatroomID;
    _chatroomUsers = chatroom.users;

    print('current user : $chatroom');
    notifyListeners();
  }
}
