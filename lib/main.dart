//main class
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/constants.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';
import 'ui/views/landing_view.dart';

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
      theme:
          ThemeData(primaryColor: darkBlueColor, accentColor: darkBlueColor),
      // initialRoute: Routes.startupViewRoute,
      home: LandingView(),
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
