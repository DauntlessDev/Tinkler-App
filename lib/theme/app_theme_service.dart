import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AppThemeService extends BaseViewModel {
  static bool isDarkModeOn = false;
  Future<void> updateTheme(bool isdarkmodeon) async {
    isDarkModeOn = isdarkmodeon;
    notifyListeners();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isdarkmodeon', AppThemeService.isDarkModeOn);
  }
}
