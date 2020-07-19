// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tinkler/ui/views/landing_view.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/views/auth/login/login_view.dart';
import 'package:tinkler/ui/views/auth/signup/signup_view.dart';
import 'package:tinkler/ui/views/home/chat/chatsearch/chatsearch_view.dart';
import 'package:tinkler/ui/views/home/chat/chatroom/chatroom_view.dart';

abstract class Routes {
  static const landingViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const loginViewRoute = '/login-view-route';
  static const signupViewRoute = '/signup-view-route';
  static const chatsearchViewRoute = '/chatsearch-view-route';
  static const chatroomViewRoute = '/chatroom-view-route';
  static const all = {
    landingViewRoute,
    homeViewRoute,
    loginViewRoute,
    signupViewRoute,
    chatsearchViewRoute,
    chatroomViewRoute,
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
      case Routes.chatsearchViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ChatSearchView(),
          settings: settings,
        );
      case Routes.chatroomViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ChatroomView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
