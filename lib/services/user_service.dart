import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class UserService extends ChangeNotifier {
  static String uid;
  void updateUserUid(String uid) {
    uid = uid;
    notifyListeners();
  }
}
