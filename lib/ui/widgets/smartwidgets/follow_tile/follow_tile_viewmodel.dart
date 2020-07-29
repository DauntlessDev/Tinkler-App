import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowTileViewModel extends BaseViewModel {
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();

  bool isVisitingOwnProfile(String email) => email == _user.email;

  Function buttonFunction({String email, String uid}) {
    return isVisitingOwnProfile(email)
        ? null
        : isFollowed
            ? () =>
                _visitProfile.unfollowingUser(otherEmail: email, otherUid: uid)
            : () =>
                _visitProfile.followingUser(otherEmail: email, otherUid: uid);
  }

  Function onPressed({String email, String uid}) {
    return () {
      buttonFunction(email: email, uid: uid);
      isFollowed = _visitProfile.isProfileFollowed(email);
    };
  }

  bool isFollowed = false;
  bool isProfileFollowed(String email) {
    isFollowed = _visitProfile.isProfileFollowed(email);
    return isFollowed;
  }

  String get buttonText => _visitProfile.buttonText(isFollowed);
}
