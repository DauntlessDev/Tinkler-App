import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VisitProfileService extends ChangeNotifier {
  String _email;
  String get email => _email;

  Future<void> updateVisitProfileEmail(String email) async {
    _email = email;
    print('visit profile : $_email');

    notifyListeners();
  }
}
