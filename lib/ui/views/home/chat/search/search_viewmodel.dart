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

class SearchViewModel extends BaseViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();
  final _chatroom = locator<CurrentChatroomService>();

  String _input = '';
  String get input => _input;
  void setInput(String value) => _input = value;

  List<Profile> listOfUsers;
  void searchUsers() async {
    if (_input.isNotEmpty) {
      setBusy(true);
      try {
        listOfUsers = await _database.usersFuture().then((listOfProfile) =>
            listOfProfile
                .where((profile) => profile.displayName
                    .toLowerCase()
                    .contains(_input.toLowerCase()))
                .toList());

        notifyListeners();
        setBusy(false);
      } on PlatformException catch (e) {
        print(e.message);
      }
    }
  }

  String getChatRoomId(String a, String b) {
    print('a:$a b: $b');
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<void> startConversation(Profile otherProfile) async {
    setBusy(true);

    _chatroom.updateOtherChatMate(otherProfile);
    final chatroom = Chatroom(
      users: [_user.email, otherProfile.email],
      chatroomID: getChatRoomId(_user.email, otherProfile.email),
    );

    await _database.addChatroom(chatroom);
    _chatroom.updateCurrentChatroom(chatroom);
    setBusy(false);

    _navigation.navigateTo(Routes.chatroomView);
  }
}
