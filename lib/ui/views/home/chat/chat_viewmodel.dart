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
  Stream get stream {
    _chat.addListener(() => notifyListeners());
    _database.chatroomsStream().listen((event) {
      if (event.isNotEmpty) getChatInfo(event);
    });
    return _database.chatroomsStream();
  }

  List<Chat> get listOfAllChats => _chat.getNonEmptyChats;
  Future<void> getChatInfo(List<Chatroom> allUserConversations) async {
    // setBusy(true);
    try {
      listOfAllChats.clear();
      if (allUserConversations != null) {
        for (Chatroom chatroom in allUserConversations) {
          Message lastMessage;
          Profile otherUserProfile;

          _database
              .messagesStreamInChat(chatroomId: chatroom.chatroomID)
              .listen(
            (value) {
              if (value == null)
                lastMessage = Message(message: '', sender: '', time: '');
              else if (value.isEmpty)
                lastMessage = Message(message: '', sender: '', time: '');
              else
                lastMessage = value.first;

              return lastMessage;
            },
          );

          for (String userInChat in chatroom.users) {
            print(
                'userInchat: $userInChat != ${_user.email} => ${userInChat != _user.email}');
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
          _chat.addChatInList(
            Chat(
              profile: otherUserProfile,
              lastMessage: lastMessage,
            ),
          );

          notifyListeners();
        }
      }
    } on PlatformException catch (e) {
      print('Chatviewmodel: chatInfo error message => ${e.message} ');
    }
  }

  void navigateToSearch() {
    _navigation.navigateTo(Routes.chatsearchViewRoute);
  }

  String formatDate(String firstTime) {
    return _formatter.formatDate(firstTime);
  }

  Future<void> startConversation(Profile otherProfile) async {
    try {
      setBusy(true);
      _chatroom.updateOtherChatMate(otherProfile);
      final chatroom = Chatroom(
        users: [_user.email, otherProfile.email],
        chatroomID: getChatroomID(otherProfile.email),
      );
      await _database.addChatroom(chatroom: chatroom);
      _chatroom.updateCurrentChatroom(chatroom);
      setBusy(false);

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
}
