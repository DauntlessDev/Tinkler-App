import 'package:auto_route/auto_route_annotations.dart';
import 'package:tinkler/ui/views/auth/login/login_view.dart';
import 'package:tinkler/ui/views/auth/signup/signup_view.dart';
import 'package:tinkler/ui/views/shared/comment_section/comment_section_view.dart';
import 'package:tinkler/ui/views/shared/follower_info/follower_info_view.dart';
import 'package:tinkler/ui/views/shared/following_info/following_info_view.dart';
import 'package:tinkler/ui/views/shared/fullpicture/fullpicture_view.dart';
import 'package:tinkler/ui/views/home/chat/chatroom/chatroom_view.dart';
import 'package:tinkler/ui/views/home/chat/chatsearch/chatsearch_view.dart';
import 'package:tinkler/ui/views/home/home_view.dart';
import 'package:tinkler/ui/views/home/search/checkprofile/checkprofile_view.dart';
import 'package:tinkler/ui/views/landing_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LandingView landingViewRoute;
  HomeView homeViewRoute;
  LoginView loginViewRoute;
  SignupView signupViewRoute;
  ChatSearchView chatsearchViewRoute;
  ChatroomView chatroomViewRoute;
  CheckProfileView checkProfileViewRoute;
  FullPictureView fullPictureViewRoute;
  FollowerInfoView followerInfoViewRoute;
  FollowingInfoView followingInfoViewRoute;
  CommentSectionView commentSectionViewRoute;
}
