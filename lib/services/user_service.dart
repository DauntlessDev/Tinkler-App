import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/model/user.dart';

@lazySingleton
class UserService extends ChangeNotifier {
  String _uid;
  String get uid => _uid;

  String _displayName;
  String get displayName => _displayName;

  String _email;
  String get email => _email;

  void updateCurrentUserInfo(User user) {
    _uid = user.uid;
    _uid = user.email;
    print('current user : $user');

    notifyListeners();
  }
}
