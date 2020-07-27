import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VisitProfileService extends ChangeNotifier {
  List<String> _email = [];
  String get email => _email.last;

  Future<void> addVisitProfileEmail(String email) async {
    _email.add(email);
    print('visit profile : ${_email.last}');

    notifyListeners();
  }

  Future<void> removeVIsitProfileEmail() async {
    _email.removeLast();
    print('visit profile : ${_email.last}');
    print('email profile list: stack = $_email');

    notifyListeners();
  }
}
