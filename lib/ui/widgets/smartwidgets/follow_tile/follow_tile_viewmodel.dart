import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowTileViewModel extends BaseViewModel {
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();
  final _navigation = locator<NavigationService>();

  Future<void> visitProfile(String email) async {
    _visitProfile.addVisitProfileEmail(email);
    _navigation.navigateTo(Routes.checkProfileViewRoute);
  }

  bool isFollowed = false;
  bool isOwnProfile = false;
  void isProfileFollowed(String email) {
    isFollowed = _visitProfile.isProfileFollowed(email);
    isOwnProfile = isVisitingOwnProfile(email);
    notifyListeners();
  }

  bool isVisitingOwnProfile(String otherEmail) => otherEmail == _user.email;
  Function buttonFunction({String email, String uid}) {
    print('isvisitng $email : ${isVisitingOwnProfile(email)}');
    return isOwnProfile
        ? null
        : isFollowed
            ? () => unfollowingUser(otherEmail: email, otherUid: uid)
            : () => followingUser(otherEmail: email, otherUid: uid);
  }

  void unfollowingUser({String otherEmail, String otherUid}) {
    _visitProfile.unfollowingUser(otherEmail: otherEmail, otherUid: otherUid);
    isFollowed = false;
    notifyListeners();
  }

  void followingUser({String otherEmail, String otherUid}) {
    _visitProfile.followingUser(otherEmail: otherEmail, otherUid: otherUid);
    isFollowed = true;
    notifyListeners();
  }

  String get buttonText => _visitProfile.buttonText(isFollowed);
}
