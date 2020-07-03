import 'package:auto_route/auto_route_annotations.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/views/landing_view.dart';
import 'package:tinkler/ui/views/login/login_view.dart';
import 'package:tinkler/ui/views/signup/signup_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LandingView landingViewRoute;
  HomeView homeViewRoute;
  LoginView loginViewRoute;
  SignupView signupViewRoute;
}
