import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';

class ChatroomViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _chatroom = locator<CurrentChatroomService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  Future<void> sendMessage() async {
    if (_input.isNotEmpty) {
      await _database.addMessage(
          chatroomId: _chatroom.chatroomId,
          message: input,
          messageId: DateTime
            .now()
            .millisecondsSinceEpoch.toString());
    }
  }
}
