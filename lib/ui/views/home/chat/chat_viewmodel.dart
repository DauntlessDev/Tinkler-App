import 'package:meta/meta.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/auth_service.dart';

class ChatViewModel extends FutureViewModel {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();

  User _user;
  User get user => _user;
  String get userPhotoUrl {
    try {
      return _user.photoUrl;
    } catch (e) {
      return '';
    }
  }

  Future<void> currentUser() async {
    _user = await _auth.currentUser();
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

  @override
  Future<void> futureToRun() => currentUser();

  List<UserChat> _chatList = [
    UserChat(
        name: 'Rom Braveheart P. Leuterio',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_1.jpg'),
    UserChat(
        name: 'Bryan Chong S. Salazar',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_2.jpg'),
    UserChat(
        name: 'Kyle Chester M. Makapagal',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_3.jpg'),
    UserChat(
        name: 'Ryan Michael P. Caluag',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_1.jpg'),
    UserChat(
        name: 'Zeus Roy P. Sambilay',
        latestMessage: 'Hello! how are you?',
        time: '4:26',
        photoUrl: 'assets/images/profile_2.jpg'),
  ];

  List<UserChat> get chatList => _chatList;
}

class UserChat {
  final String name;
  final String photoUrl;
  final String latestMessage;
  final String time;

  const UserChat({
    @required this.name,
    @required this.photoUrl,
    @required this.latestMessage,
    @required this.time,
  });
}
