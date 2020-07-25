import 'package:stacked/stacked.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class CheckProfileViewModel extends FutureViewModel<Profile> {
  final _database = locator<DatabaseService>();
  final _visitProfile = locator<VisitProfileService>();

  Profile get profile {
    return (data == null)
        ? Profile(
            photoUrl: '',
            displayName: '',
            email: '',
            followers: 0,
            following: 0,
            posts: 0,
          )
        : Profile(
            photoUrl: data.photoUrl ?? '',
            email: data.email,
            displayName: data.displayName,
            followers: data.followers,
            following: data.following,
            posts: data.posts,
          );
  }

  Future<Profile> profileFuture() async {
    setBusy(true);
    List<Profile> profileList =
        await _database.profileFuture(email: _visitProfile.email);
    setBusy(false);
    return profileList.first;
  }

  @override
  Future<Profile> futureToRun() => profileFuture();
}
