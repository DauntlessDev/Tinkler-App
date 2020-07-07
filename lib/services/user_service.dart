import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService extends ChangeNotifier {
  String _uid;
  String get uid => _uid;

  void updateUserUid(String uid) {
    _uid = uid;
    print('current user id : ${_uid}');

    notifyListeners();
  }
}
