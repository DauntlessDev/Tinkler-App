import 'package:auto_route/auto_route_annotations.dart';
import 'package:tinkler/ui/views/auth/login/login_view.dart';
import 'package:tinkler/ui/views/auth/signup/signup_view.dart';
import 'package:tinkler/ui/views/home/chat/search/search_view.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/views/landing_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LandingView landingViewRoute;
  HomeView homeViewRoute;
  LoginView loginViewRoute;
  SignupView signupViewRoute;
  SearchView searchViewRoute;
}
