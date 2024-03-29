import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class ChatSearchViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();
  final _chatroom = locator<CurrentChatroomService>();
  final _dialog = locator<DialogService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  List<Profile> listOfUsers;
  void searchUsers() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      try {
        listOfUsers = await _database.usersFuture(_input);
        notifyListeners();
        setBusy(false);
      } on PlatformException catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> startConversation(Profile otherProfile) async {
    try {
      _chatroom.updateOtherChatMate(otherProfile);

      final chatroom = Chatroom(
        users: [_user.email, otherProfile.email],
        chatroomID: _chatroom.getChatRoomId(_user.email, otherProfile.email),
      );
      _chatroom.updateCurrentChatroom(chatroom);

      _navigation.navigateTo(Routes.chatroomViewRoute);
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Chat', description: e.message);
    }
  }
}
