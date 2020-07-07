import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class UserService {
  String _uid;
  String get uid => _uid;

  void updateUserUid(String uid) {
    _uid = uid;
  }
}
