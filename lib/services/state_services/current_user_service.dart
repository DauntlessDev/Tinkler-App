import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/model/user.dart';

@lazySingleton
class CurrentUserService extends ChangeNotifier {
  String _uid;
  String get uid => _uid;

  String _email;
  String get email => _email;

  void updateCurrentUserInfo(User user) {
    _uid = user.uid;
    _email = user.email;
    print('current user : $user');

    notifyListeners();
  }
}
