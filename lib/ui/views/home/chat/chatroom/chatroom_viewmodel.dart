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

  List<Message> get messages => data;

  Stream<List<Message>> getMessages() {
    updateOtherUserInfo();
    _database.messagesStream().listen((event) {
      initiateShowTime(event.length);
    });

    return _database.messagesStream();
  }

  @override
  Stream<List<Message>> get stream => getMessages();

  List<bool> _isShowTime = [];
  List<bool> get isShowTime => _isShowTime;
  void initiateShowTime(int length) {
    for (int i = 0; i < length; i++) {
      _isShowTime.add(false);
    }
    print(_isShowTime);
  }

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

  bool isUser(String email) {
    // print(_user.email == email);
    return _user.email == email;
  }

  bool isLastSend({String sender, String nextSender}) {
    return (sender != nextSender);
  }

  String otherDisplayName;
  String otherPhotoUrl;
  void updateOtherUserInfo() {
    otherDisplayName = _chatroom.otherDisplayName;
    otherPhotoUrl = _chatroom.otherPhotoUrl;
  }

  void toggleisShowTime(int index) {
    _isShowTime[index] = !_isShowTime[index];
    print('isSHowntime : $index');
    notifyListeners();
  }
}
