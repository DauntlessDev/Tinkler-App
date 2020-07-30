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
  }

  bool isProfileFollowed(String email) {
    return followingEmailList.contains(email);
  }

  void updateUserFollowingCount() async {
    Profile currentProfileInfo;
    await _database
        .profileFuture(email: _user.email)
        .then((value) => currentProfileInfo = value.first);

    int followingCount = 0;
    await _database
        .allFollowingFuture(uid: _user.uid)
        .then((value) => followingCount = value.length);
    await _database
        .setProfile(currentProfileInfo.copyWith(following: followingCount));
  }

  Future<void> updateOtherFollowersCount(
      {@required String otherEmail, int latestFollowersCount}) async {
    Profile othersProfileInfo;
    await _database
        .profileFuture(email: otherEmail)
        .then((value) => othersProfileInfo = value.first);

    _database.setProfile(
        othersProfileInfo.copyWith(followers: latestFollowersCount));
  }

  Future<void> addOtherFollower(String uid) async {
    await _database.addFollower(uid: uid, follow: Record(email: _user.email));
  }

  Future<void> deleteOtherFollower(String otherUid) async {
    await _database.deleteFollower(uid: otherUid, email: _user.email);
  }

  Future<void> addUserFollowing(String otherEmail) async {
    await _database.addFollowing(
        uid: _user.uid, follow: Record(email: otherEmail));
  }

  Future<void> deleteUserFollowing(String otherEmail) async {
    await _database.deleteFollowing(uid: _user.uid, email: otherEmail);
  }

  Future<void> followingUser(
      {String otherEmail,
      String otherUid,
      @required int latestFollowersCount}) async {
    await addUserFollowing(otherEmail);
    await addOtherFollower(otherUid);
    updateUserFollowingCount();
    updateOtherFollowersCount(
        otherEmail: otherEmail, latestFollowersCount: latestFollowersCount);
    print('finished followed');
  }

  Future<void> unfollowingUser(
      {String otherEmail,
      String otherUid,
      @required int latestFollowersCount}) async {
    await deleteUserFollowing(otherEmail);
    await deleteOtherFollower(otherUid);
    updateUserFollowingCount();
    updateOtherFollowersCount(
        otherEmail: otherEmail, latestFollowersCount: latestFollowersCount);
    print('finished unfollow');
  }

  String buttonText(bool isFollowed) {
    return isFollowed ? 'unfollow' : 'follow';
  }
}
