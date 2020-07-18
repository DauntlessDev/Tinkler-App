import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/profile.dart';

@lazySingleton
class CurrentChatroomService extends ChangeNotifier {
  String _chatroomId;
  String get chatroomId => _chatroomId;

  List<String> _chatroomUsers;
  List<String> get chatroomUsers => _chatroomUsers;
  void updateCurrentChatroom(Chatroom chatroom) {
    _chatroomId = chatroom.chatroomID;
    _chatroomUsers = chatroom.users;

    print('current chatroom : $chatroom');
    notifyListeners();
  }

  String _otherDisplayName;
  String get otherDisplayName => _otherDisplayName;

  String _otherPhotoUrl;
  String get otherPhotoUrl => _otherPhotoUrl;

  String _otherEmail;
  String get otherEmail => _otherEmail;

  void updateOtherChatMate(Profile otherProfile) {
    _otherDisplayName = otherProfile.displayName;
    _otherPhotoUrl = otherProfile.photoUrl;
    _otherEmail = otherProfile.email;

    notifyListeners();
  }

  String getChatRoomId(String a, String b) {
    print('a:$a b: $b');
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
