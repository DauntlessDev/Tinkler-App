// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tinkler/ui/views/landing_view.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/views/login/login_view.dart';
import 'package:tinkler/ui/views/signup/signup_view.dart';

abstract class Routes {
  static const landingViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const loginViewRoute = '/login-view-route';
  static const signupViewRoute = '/signup-view-route';
  static const all = {
    landingViewRoute,
    homeViewRoute,
    loginViewRoute,
    signupViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LandingView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.signupViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignupView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
