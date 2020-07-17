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
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/formatter_service.dart';

class ChatViewModel extends StreamViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();
  final _chatroom = locator<CurrentChatroomService>();
  final _formatter = locator<FormatterService>();

  // List<Chatroom> get allUserConversations => data;
  @override
  Stream get stream {
    _database.chatroomsStream().listen((event) {
      if (event.isNotEmpty) getChatInfo(event);
    });
    return _database.chatroomsStream();
  }

  List<Chat> listOfAllChats = [];
  Future<void> getChatInfo(List<Chatroom> allUserConversations) async {
    // setBusy(true);
    try {
      print('all user convo: $allUserConversations');
      if (allUserConversations != null) {
        for (Chatroom chatroom in allUserConversations) {
          Message lastMessage;
          Profile otherUserProfile;

          // await _database
          //     .messagesFuture(chatroomId: chatroom.chatroomID)
          //     .then((value) => lastMessage = value.last);

          await _database
              .messagesFuture(chatroomId: chatroom.chatroomID)
              .then((value) {
            print('list of messagse : $value');
            lastMessage = value.last;
          });

          // for (String userInChat in chatroom.users) {
          //   if (userInChat != _user.email) {
          //     await _database
          //         .profileFuture(email: userInChat)
          //         .then((value) => otherUserProfile = value.last);
          //   }
          // }

          for (String userInChat in chatroom.users) {
            print(
                'userInchat: $userInChat != ${_user.email} => ${userInChat != _user.email}');
            if (userInChat != _user.email) {
              await _database.profileFuture(email: userInChat).then((value) {
                print('list of profile in chatroom: $value');
                otherUserProfile = value.first;

                print('otherUserProfile: $otherUserProfile');
              });
            }
          }
          
          

          listOfAllChats.add(
            Chat(
                name: otherUserProfile.displayName,
                photoUrl: otherUserProfile.photoUrl,
                lastMessage: lastMessage.message,
                time: lastMessage.time),
          );
          notifyListeners();
          print('list of all chats: $listOfAllChats');
        }
        notifyListeners();
        print('last list of all chats: $listOfAllChats');
      }
    } on PlatformException catch (e) {
      print('Chatviewmodel: chatInfo error message => ${e.message} ');
    }
    // setBusy(false);
  }

  void navigateToSearch() {
    _navigation.navigateTo(Routes.searchViewRoute);
  }

  Future<void> startConversation(Profile otherProfile) async {
    setBusy(true);
    _chatroom.updateOtherChatMate(otherProfile);
    final chatroom = Chatroom(
      users: [_user.email, otherProfile.email],
      chatroomID: _chatroom.getChatRoomId(_user.email, otherProfile.email),
    );
    await _database.addChatroom(chatroom: chatroom);
    _chatroom.updateCurrentChatroom(chatroom);
    setBusy(false);

    _navigation.navigateTo(Routes.chatroomView);
  }

  String formatDate(String firstTime) {
    return _formatter.formatDate(firstTime);
  }
}
