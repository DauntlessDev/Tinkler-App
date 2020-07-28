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

  bool isFollowed = false;
  void checkIfFollowed() {
    _database
        .followingStream(uid: _user.uid, email: _email.last)
        .listen((followingList) {
      if (followingList != null) {
        print('following list : $followingList');
        isFollowed = followingList.isNotEmpty;
        print(isFollowed);
        notifyListeners();
      }
    });
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
    updateUserFollowingCount(toUnfollow: isFollowed);
    updateOtherFollowersCount(toUnFollow: isFollowed);
    print('finished followed');
  }

  Future<void> unfollowingUser({String otherEmail, String otherUid}) async {
    deleteUserFollowing(otherEmail);
    deleteOtherFollower(otherUid);
    updateUserFollowingCount(toUnfollow: isFollowed);
    updateOtherFollowersCount(toUnFollow: isFollowed);
    print('finished unfollow');
  }

  String buttonText() {
    return isFollowed ? 'unfollow' : 'follow';
  }
}
