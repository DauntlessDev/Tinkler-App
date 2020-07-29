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
  bool isProfileFollowed(String email) {
    isFollowed = _visitProfile.isProfileFollowed(email);
    return isFollowed;
  }

  bool isVisitingOwnProfile(String otherEmail) => otherEmail == _user.email;
  Function buttonFunction({String email, String uid}) {
    print('isvisitng $email : ${isVisitingOwnProfile(email)}');
    return isVisitingOwnProfile(email)
        ? null
        : isFollowed
            ? () => unfollowingUser(otherEmail: email, otherUid: uid)
            : () => followingUser(otherEmail: email, otherUid: uid);
  }

  Future<void> unfollowingUser({String otherEmail, String otherUid}) async {
    setBusy(true);
    await _visitProfile.unfollowingUser(
        otherEmail: otherEmail, otherUid: otherUid);
    isFollowed = _visitProfile.isProfileFollowed(otherEmail);
    print('isFollowed : $isFollowed');
    notifyListeners();
    setBusy(false);
  }

  Future<void> followingUser({String otherEmail, String otherUid}) async {
    setBusy(true);
    await _visitProfile.followingUser(
        otherEmail: otherEmail, otherUid: otherUid);
    isFollowed = _visitProfile.isProfileFollowed(otherEmail);
    print('isFollowed : $isFollowed');
    notifyListeners();
    setBusy(false);
  }

  String get buttonText => _visitProfile.buttonText(isFollowed);
}
