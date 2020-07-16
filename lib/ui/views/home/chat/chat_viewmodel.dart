import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/chatroom.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

class ChatViewModel extends StreamViewModel {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();
  final _chatroom = locator<CurrentChatroomService>();

  List<Chatroom> get allUserConversations => data;
  @override
  Stream get stream => getAllUserConversations();
  Stream<List<Chatroom>> getAllUserConversations() {
    return _database.chatroomsStream();
  }

  void getChatInfo() {
    // allUserConversations.
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
    await _database.addChatroom(chatroom);
    _chatroom.updateCurrentChatroom(chatroom);
    setBusy(false);

    _navigation.navigateTo(Routes.chatroomView);
  }
}
