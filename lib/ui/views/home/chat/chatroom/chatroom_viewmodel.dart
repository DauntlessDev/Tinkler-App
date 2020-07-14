import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/message.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class ChatroomViewModel extends StreamViewModel<List<Message>> {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _chatroom = locator<CurrentChatroomService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  Future<void> sendMessage() async {
    if (_input.isNotEmpty) {
      await _database.addMessage(
          message: Message(
            sender: _user.email,
            message: _input,
            time: DateTime.now().toIso8601String(),
          ),
          messageId: DateTime.now().millisecondsSinceEpoch.toString());
    }
    _input = '';
  }

  Stream<List<Message>> getMessages() {
    updateOtherUserInfo();
    return _database.messagesStream();
  }

  List<Message> get messages => data;

  bool isUser(String email) {
    print(_user.email == email);
    return _user.email == email;
  }

  String otherDisplayName;
  String otherPhotoUrl;
  void updateOtherUserInfo() {
    otherDisplayName = _chatroom.otherDisplayName;
    otherPhotoUrl = _chatroom.otherPhotoUrl;
  }

  @override
  Stream<List<Message>> get stream => getMessages();
}
