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
    return () async {
      buttonFunction(email: email, uid: uid);
      isFollowed = await _visitProfile.isProfileFollowed(email);
    };
  }

  bool isFollowed = false;
  Future<bool> isProfileFollowed(String email) async =>
      await _visitProfile.isProfileFollowed(email);

  String get buttonText => _visitProfile.buttonText(isFollowed);
}
