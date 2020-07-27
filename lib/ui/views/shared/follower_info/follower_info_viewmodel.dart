import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class FollowerInfoViewModel extends FutureViewModel<List<Profile>> {
  final _visitProfile = locator<VisitProfileService>();
  final _database = locator<DatabaseService>();
  final _navigation = locator<NavigationService>();

  Future<List<Profile>> checkFollowers() async {
    String userUid = '';
    await _database
        .profileFuture(email: _visitProfile.email)
        .then((value) => userUid = value.first.uid);

    List<String> followersEmailList =
        await _database.allFollowersFuture(uid: userUid);

    List<Profile> followersProfileList = [];
    for (String email in followersEmailList) {
      Profile currentProfile;
      await _database
          .profileFuture(email: email)
          .then((value) => currentProfile = value.first);

      followersProfileList.add(currentProfile);
    }
    print(followersProfileList);
    return followersProfileList;
  }

  @override
  Future<List<Profile>> futureToRun() => checkFollowers();

  List<Profile> get followersProfileList => data;

  Future<void> visitProfile(String email) async {
    _visitProfile.addVisitProfileEmail(email);
    _navigation.navigateTo(Routes.checkProfileViewRoute);
  }
}
