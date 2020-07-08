import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AppThemeService extends BaseViewModel {
  static bool isDarkModeOn = false;
  void updateTheme(bool isdarkmodeon) {
    isDarkModeOn = isdarkmodeon;
    notifyListeners();
  }
}
