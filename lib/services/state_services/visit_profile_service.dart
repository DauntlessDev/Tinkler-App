import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/model/record.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';

@lazySingleton
class VisitProfileService extends ChangeNotifier {
  final _database = locator<DatabaseService>();
  final _user = locator<CurrentUserService>();

  List<String> _email = [];
  String get email => _email.last;

  Future<void> addVisitProfileEmail(String email) async {
    _email.add(email);
    notifyListeners();
  }

  Future<void> removeVisitProfileEmail() async {
    _email.removeLast();
    notifyListeners();
  }

  List<String> followingEmailList = [];
  void checkUserFollowing() async {
    _database.allFollowingStream(uid: _user.uid).listen((event) {
      followingEmailList = event;
      notifyListeners();
    });

    // List<Profile> followingProfileList = [];
    // for (String email in followingEmailList) {
    //   Profile currentProfile;
    //   await _database
    //       .profileFuture(email: email)
    //       .then((value) => currentProfile = value.first);

    //   followingProfileList.add(currentProfile);
    // }
    // print('list of following: $followingEmailList');
    // return followingProfileList;
  }

  Future<bool> isProfileFollowed(String email) async {
    print('$email is follow: ${followingEmailList.contains(email)}');
    return followingEmailList.contains(email);
  }

  void updateUserFollowingCount({@required bool toUnfollow}) async {
    Profile currentProfileInfo;
    await _database
        .profileFuture(email: _user.email)
        .then((value) => currentProfileInfo = value.first);

    toUnfollow
        ? _database.setProfile(currentProfileInfo.copyWith(
            following: currentProfileInfo.following - 1))
        : _database.setProfile(currentProfileInfo.copyWith(
            following: currentProfileInfo.following + 1));
  }

  Future<void> updateOtherFollowersCount({@required bool toUnFollow}) async {
    Profile othersProfileInfo;
    await _database
        .profileFuture(email: _email.last)
        .then((value) => othersProfileInfo = value.first);

    toUnFollow
        ? _database.setProfile(othersProfileInfo.copyWith(
            followers: othersProfileInfo.followers - 1))
        : _database.setProfile(othersProfileInfo.copyWith(
            followers: othersProfileInfo.followers + 1));
  }

  Future<void> addOtherFollower(String uid) async {
    _database.addFollower(uid: uid, follow: Record(email: _user.email));
  }

  Future<void> deleteOtherFollower(String otherUid) async {
    _database.deleteFollower(uid: otherUid, email: _user.email);
  }

  Future<void> addUserFollowing(String otherEmail) async {
    _database.addFollowing(uid: _user.uid, follow: Record(email: otherEmail));
  }

  Future<void> deleteUserFollowing(String otherEmail) async {
    _database.deleteFollowing(uid: _user.uid, email: otherEmail);
  }

  Future<void> followingUser({String otherEmail, String otherUid}) async {
    addUserFollowing(otherEmail);
    addOtherFollower(otherUid);
    updateUserFollowingCount(toUnfollow: false);
    updateOtherFollowersCount(toUnFollow: false);
    print('finished followed');
  }

  Future<void> unfollowingUser({String otherEmail, String otherUid}) async {
    deleteUserFollowing(otherEmail);
    deleteOtherFollower(otherUid);
    updateUserFollowingCount(toUnfollow: true);
    updateOtherFollowersCount(toUnFollow: true);
    print('finished unfollow');
  }

  String buttonText(bool isFollowed) {
    return isFollowed ? 'unfollow' : 'follow';
  }
}
