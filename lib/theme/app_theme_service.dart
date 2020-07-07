import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppThemeService extends ChangeNotifier {
  static bool isDarkModeOn = false;
  void updateTheme(bool isdarkmodeon) {
    isDarkModeOn = isdarkmodeon;
    notifyListeners();
  }
}
