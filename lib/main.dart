//main class
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/theme/app_theme.dart';
import 'package:tinkler/theme/app_theme_service.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinkler',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          AppThemeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
