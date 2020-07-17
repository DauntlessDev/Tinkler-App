//main class
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/theme/app_theme.dart';
import 'package:tinkler/theme/app_theme_service.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AppThemeService.isDarkModeOn = prefs.getBool('isdarkmodeon') ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppThemeService>.reactive(
      viewModelBuilder: () => locator<AppThemeService>(),
      builder: (context, model, child) => MaterialApp(
        title: 'Tinkler',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            AppThemeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
