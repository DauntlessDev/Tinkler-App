import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/authentication_service.dart';
import 'package:tinkler/services/database_service.dart';
import 'package:tinkler/services/user_service.dart';

class ChatViewModel extends BaseViewModel {
  final _auth = locator<AuthenticationService>();
  final _dialog = locator<DialogService>();
  final _navigation = locator<NavigationService>();
  final _user = locator<UserService>();
  final _database = locator<DatabaseService>();

  Profile _userInfo;
  Profile get user => _userInfo;
  String get userPhotoUrl {
    try {
      return _userInfo.photoUrl;
    } catch (e) {
      return '';
    }
  }

  void navigateToSearch() {
    _navigation.navigateTo(Routes.searchViewRoute);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  sendMessage(String email) {
    List<String> users = [_user.email, email];

    String chatRoomId = getChatRoomId(_user.email, email);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    // _database.addChatRoom(chatRoom, chatRoomId);

    // _navigation.
  

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Chat(
    //               chatRoomId: chatRoomId,
    //             )));
  }

  List<Chat> _chatList = [
    Chat(
        name: 'Rom Braveheart P. Leuterio',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_1.jpg'),
    Chat(
        name: 'Bryan Chong S. Salazar',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_2.jpg'),
    Chat(
        name: 'Kyle Chester M. Makapagal',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_3.jpg'),
    Chat(
        name: 'Ryan Michael P. Caluag',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_1.jpg'),
    Chat(
        name: 'Zeus Roy P. Sambilay',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_2.jpg'),
  ];

  List<dynamic> get list => _chatList;
}
