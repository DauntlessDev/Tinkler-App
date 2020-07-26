import 'package:meta/meta.dart';
import 'package:stacked/stacked.dart';

import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/post.dart';
import 'package:tinkler/model/postprofile.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/state_services/visit_profile_service.dart';

class CheckProfileViewModel extends FutureViewModel<Profile> {
  final _database = locator<DatabaseService>();
  final _visitProfile = locator<VisitProfileService>();
  final _user = locator<CurrentUserService>();

  Future<Profile> profileFuture() async {
    setBusy(true);
    List<Profile> profileList =
        await _database.profileFuture(email: _visitProfile.email);
    setBusy(false);
    return profileList.first;
  }

  Profile get profile {
    return (data == null)
        ? Profile(
            uid: '',
            photoUrl: '',
            displayName: '',
            email: '',
            followers: 0,
            following: 0,
            posts: 0,
          )
        : Profile(
            uid: data.uid,
            photoUrl: data.photoUrl ?? '',
            email: data.email,
            displayName: data.displayName,
            followers: data.followers,
            following: data.following,
            posts: data.posts,
          );
  }

  List<PostProfile> ownPostProfileList = [];
  Future<List<Post>> ownPostFuture() async =>
      await _database.specificPostFuture(_visitProfile.email);
  List<Post> ownPostList = [];
  @override
  Future<Profile> futureToRun() async {
    ownPostList = await ownPostFuture();
    Profile profile = await profileFuture().then((value) => value);
    setPosts(ownPostList, profile);
    return profile;
  }

  Future<void> setPosts(List<Post> event, Profile senderProfile) async {
    setBusy(true);
    ownPostProfileList.clear();

    for (Post post in event) {
      ownPostProfileList.add(
        PostProfile(
            post: Post(
              description: post.description,
              posterEmail: post.posterEmail,
              postId: post.postId,
              time: post.time,
              pictureUrl: post.pictureUrl ?? '',
              commentsCount: post.commentsCount,
              likesCount: post.likesCount,
            ),
            posterProfile: senderProfile),
      );
    }
    notifyListeners();
    setBusy(false);
  }

  bool isVisitingOwnProfile() => profile.email == _user.email;
  bool isFollowed() => false;

  void updateUserFollowingCount({@required bool toFollow}) async {
    Profile currentProfileInfo;
    await _database
        .profileFuture(email: _user.email)
        .then((value) => currentProfileInfo = value.first);

    toFollow
        ? _database.setProfile(currentProfileInfo.copyWith(
            following: currentProfileInfo.following + 1))
        : _database.setProfile(currentProfileInfo.copyWith(
            following: currentProfileInfo.following - 1));
  }

  Future<void> updateOtherFollowersCount({@required bool toFollow}) async {
    Profile othersProfileInfo;
    await _database
        .profileFuture(email: profile.email)
        .then((value) => othersProfileInfo = value.first);

    toFollow
        ? _database.setProfile(othersProfileInfo.copyWith(
            followers: othersProfileInfo.followers + 1))
        : _database.setProfile(othersProfileInfo.copyWith(
            followers: othersProfileInfo.followers - 1));
  }

  Future<void> followingUser() async {
    bool toFollow = true;
    updateUserFollowingCount(toFollow: toFollow);
    updateOtherFollowersCount(toFollow: toFollow);
  }
}
