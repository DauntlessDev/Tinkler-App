import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/message.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/all_chat_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class ChatroomViewModel extends StreamViewModel<List<Message>> {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _chatroom = locator<CurrentChatroomService>();
  final _formatter = locator<FormatterService>();
  final _chat = locator<AllChatService>();

  List<Message> get messages => data;

  Stream<List<Message>> getMessages() {
    _chat.addListener(() => notifyListeners());
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
  }

  void toggleisShowTime(int index) {
    _isShowTime[index] = !_isShowTime[index];
    notifyListeners();
  }

  bool ifShowDate(String firstTime, String secondTime) {
    DateTime firstDate = DateTime.parse(firstTime);
    DateTime secondDate = DateTime.parse(secondTime);

    return (firstDate.difference(secondDate).abs() >= Duration(hours: 6));
  }

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  Future<void> sendMessage() async {
    if (_input.isNotEmpty) {
      Message lastMessage = Message(
        sender: _user.email,
        message: _input,
        time: DateTime.now().toIso8601String(),
      );
      await _database.addMessage(
          message: lastMessage,
          messageId: DateTime.now().millisecondsSinceEpoch.toString());

      _chat.setLastMessageOfSpecificChat(
          email: otherEmail, message: lastMessage);
    }
    _input = '';
  }

  bool isUser(String email) {
    return _user.email == email;
  }

  bool isLastSend({String sender, String nextSender}) {
    return (sender != nextSender);
  }

  String otherDisplayName;
  String otherPhotoUrl;
  String otherEmail;
  void updateOtherUserInfo() {
    otherDisplayName = _chatroom.otherDisplayName;
    otherPhotoUrl = _chatroom.otherPhotoUrl;
    otherEmail = _chatroom.otherEmail;
  }

  String formatDate(String firstTime) {
    return _formatter.formatDate(firstTime);
  }
}
