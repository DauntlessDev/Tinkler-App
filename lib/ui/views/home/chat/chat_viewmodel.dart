import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/message.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/all_chat_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class ChatViewModel extends StreamViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _dialog = locator<DialogService>();
  final _navigation = locator<NavigationService>();
  final _chatroom = locator<CurrentChatroomService>();
  final _formatter = locator<FormatterService>();
  final _chat = locator<AllChatService>();

  // List<Chatroom> get allUserConversations => data;
  @override
  Stream get stream => refresh ? chatSetup() : chatSetup();

  Stream chatSetup() {
    _chat.clear();
    _chat.addListener(() => notifyListeners());
    _database.chatroomsStream().listen((event) async {
      if (event.isNotEmpty) await (getChatInfo(event));
    });
    notifyListeners();
    return _database.chatroomsStream();
  }

  List<Chat> get listOfAllChats => _chat.getNonEmptyChats;

  bool setUp = false;
  Future<void> getChatInfo(List<Chatroom> allUserConversations) async {
    setUp = true;
    // print('all user convo: $allUserConversations');
    try {
      List<Chat> _privateChat = [];
      _chat.getNonEmptyChats.clear();
      if (allUserConversations != null) {
        for (Chatroom chatroom in allUserConversations) {
          Message lastMessage = chatroom.lastMessage;
          Profile otherUserProfile;

          for (String userInChat in chatroom.users) {
            // print(
            //     'userInchat: $userInChat != ${_user.email} => ${userInChat != _user.email}');
            if (userInChat != _user.email) {
              await _database
                  .profileFuture(email: userInChat)
                  .then((value) => otherUserProfile = value.first);
            }
          }

          if (otherUserProfile == null) {
            for (String userInChat in chatroom.users) {
              if (userInChat == _user.email) {
                await _database
                    .profileFuture(email: userInChat)
                    .then((value) => otherUserProfile = value.first);
              }
            }
          }
          _privateChat.add(
            Chat(
              profile: otherUserProfile,
              lastMessage: lastMessage,
            ),
          );

          notifyListeners();
        }

        _chat.updateChatList(_privateChat);
      }
    } on PlatformException catch (e) {
      print('Chatviewmodel: chatInfo error message => ${e.message} ');
    }

    setUp = false;
  }

  void navigateToSearch() {
    _navigation.navigateTo(Routes.chatsearchViewRoute);
  }

  String formatDate(String firstTime) {
    return _formatter.formatDate(firstTime);
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

  Future<void> deleteChatroom(String otherEmail) async {
    try {
      await _database.deleteChatroom(chatroomId: getChatroomID(otherEmail));
    } on PlatformException catch (e) {
      _dialog.showDialog(title: 'Chat', description: e.message);
    }
  }

  String getChatroomID(otherEmail) =>
      _chatroom.getChatRoomId(_user.email, otherEmail);

  bool refresh = true;

  void reloadPage() async {
    refresh = !refresh;
    notifySourceChanged();
  }
}
