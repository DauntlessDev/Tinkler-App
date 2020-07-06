import 'package:meta/meta.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/chat.dart';
import 'package:tinkler/model/user.dart';
import 'package:tinkler/services/authentication_service.dart';

class ChatViewModel extends BaseViewModel {
  final _auth = locator<AuthenticationService>();
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
