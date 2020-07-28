import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowingInfoViewModel extends FutureViewModel<List<Profile>> {
  final _visitProfile = locator<VisitProfileService>();
  final _database = locator<DatabaseService>();
  final _navigation = locator<NavigationService>();

  Future<List<Profile>> checkOtherFollowing() async {
    String userUid = '';
    await _database
        .profileFuture(email: _visitProfile.email)
        .then((value) => userUid = value.first.uid);

    List<String> followingEmailList =
        await _database.allFollowingFuture(uid: userUid);

    List<Profile> followingProfileList = [];
    for (String email in followingEmailList) {
      Profile currentProfile;
      await _database
          .profileFuture(email: email)
          .then((value) => currentProfile = value.first);

      followingProfileList.add(currentProfile);
    }
    print(followingProfileList);
    return followingProfileList;
  }

  @override
  Future<List<Profile>> futureToRun() => checkOtherFollowing();

  List<Profile> get followedProfileList => data;

  Future<void> visitProfile(String email) async {
    _visitProfile.addVisitProfileEmail(email);
    _navigation.navigateTo(Routes.checkProfileViewRoute);
  }
}
